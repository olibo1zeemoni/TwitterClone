//
//  TweetService.swift
//  TwitterClone
//
//  Created by Olibo moni on 21/06/2022.
//Timestamp(date: Date())

import Firebase
import FirebaseFirestoreSwift
import Foundation

struct TweetService {
    
    func uploadTweet(caption: String, completion: @escaping(Bool) -> Void) {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        let data: Dictionary<String, Any> = ["uid": uid,
                                             "caption": caption,
                                             "likes": 0,
                                             "retweets": 0,
                                             "timestamp": Timestamp(date: Date())]
        
        let collection = Firestore.firestore().collection("tweets")
        
        collection.document().setData(data, merge: true) { error in
            
            if let error = error {
                print("DEBUG: Failed to upload tweet with error \(error.localizedDescription)")
                completion(false)
                return
            } else {
                completion(true)
            }
            
            // if not intereted in error
            //        collection.addDocument(data: data)
            //        completion(true)
            
        }
    }
    
    func fetchTweets(completion: @escaping([Tweet]) -> Void) {
        Firestore.firestore().collection("tweets")
            .order(by: "timestamp", descending: true)
            .getDocuments { snapshot, _ in
                guard let documents = snapshot?.documents else { return }
                let tweets = documents.compactMap ({ try? $0.data(as: Tweet.self) })
                completion(tweets)
            }
    }
    
    //user uid passed in to fetch user info
    func fetchTweets(forUId uid: String, completion:@escaping([Tweet]) -> Void) {
        Firestore.firestore().collection("tweets")
            .whereField("uid", isEqualTo: uid)
            .getDocuments { snapshot, _ in
                guard let documents = snapshot?.documents else { return }
                let tweets = documents.compactMap ({ try? $0.data(as: Tweet.self) })
                completion(tweets.sorted(by: { $0.timestamp.dateValue() > $1.timestamp.dateValue() }))
            }
    }
    
    
    
    
}

//MARK: - Likes
extension TweetService {
    func likeTweet(tweet: Tweet, completion: @escaping() -> Void) {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        guard let tweetId = tweet.id else { return }
        
        let userLikesRef = Firestore.firestore().collection("users").document(uid).collection("user-likes")
               
    let db =  Firestore.firestore().collection("tweets").document(tweetId)
        
            db.updateData(["likes": FieldValue.increment(Int64(1))]) { _ in
                userLikesRef.document(tweetId).setData([:]) { _ in
                    completion()

            }
        }
        
    }
    
    func unlikeTweet(_ tweet: Tweet, completion: @escaping()->Void) {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        guard let tweetId = tweet.id else { return }
        guard tweet.likes > 0 else { return }
        
        let userLikesRef = Firestore.firestore().collection("users").document(uid).collection("user-likes")
        
        let db = Firestore.firestore().collection("tweets").document(tweetId)              
        
        db.updateData(["likes": FieldValue.increment(Int64(-1)) ]) { _ in
            userLikesRef.document(tweetId).delete() { _ in
                completion()
                
            }
        }
        
    }
    
    func  checkIfUserLikedTweet(_ tweet: Tweet, completion: @escaping(Bool) -> Void) {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        guard let tweetId = tweet.id else { return }
        
        Firestore.firestore()
            .collection("users").document(uid)
            .collection("user-likes")
            .document(tweetId).getDocument { snapshot, _ in
                guard let snapshot = snapshot else { return }
                completion(snapshot.exists) //whether the document exists
        }
    }
    
    func fetchLikedTweets(forUid uid: String, completion: @escaping([Tweet]) -> Void) {
        var likedTweets = [Tweet]()
        Firestore.firestore().collection("users").document(uid).collection("user-likes").getDocuments { snapshot, _ in
            guard let documents = snapshot?.documents else { return }
            
            documents.forEach { doc in
                let tweetId = doc.documentID
                
                Firestore.firestore().collection("tweets").document(tweetId).getDocument { snapshot, _ in
                    guard let tweet = try? snapshot?.data(as: Tweet.self)  else { return }
                    likedTweets.append(tweet)
                    completion(likedTweets)
                }
            }
        }
    }
    
}

//MARK: - Retweet
extension TweetService {
    func retweet(tweet: Tweet, completion: @escaping() -> Void) {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        guard let tweetId = tweet.id else { return }
        
        let userRetweetsRef = Firestore.firestore().collection("users").document(uid).collection("user-retweets")
        
        Firestore.firestore().collection("tweets").document(tweetId)
            .updateData(["retweets": FieldValue.increment(Int64(1))]) { _ in
                userRetweetsRef.document(tweetId).setData([:]) { _ in
                    completion()
            }
        }
    }
    
    func unRetweet(_ tweet: Tweet, completion: @escaping()->Void) {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        guard let tweetId = tweet.id else { return }
        guard tweet.retweets >= 1 else { return }
        
        let userRetweetsRef = Firestore.firestore().collection("users").document(uid).collection("user-retweets")
        
        Firestore.firestore().collection("tweets").document(tweetId)
            .updateData(["retweets": FieldValue.increment(Int64(-1))]) { _ in
                userRetweetsRef.document(tweetId).delete() { _ in
                    completion()
            }
        }
    }
    
    func  checkIfUserRetweetedTweet(_ tweet: Tweet, completion: @escaping(Bool) -> Void) {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        guard let tweetId = tweet.id else { return }
        
        Firestore.firestore()
            .collection("users").document(uid)
            .collection("user-retweets")
            .document(tweetId).getDocument { snapshot, _ in
                guard let snapshot = snapshot else { return }
                completion(snapshot.exists) //whether the document exists
        }
    }
    
    func fetchReTweets(forUid uid: String, completion: @escaping([Tweet]) -> Void) {
        var reTweetedTweets = [Tweet]()
        Firestore.firestore().collection("users").document(uid).collection("user-retweets").getDocuments { snapshot, _ in
            guard let documents = snapshot?.documents else { return }
            
            documents.forEach { doc in
                let tweetId = doc.documentID
                
                Firestore.firestore().collection("tweets").document(tweetId).getDocument { snapshot, _ in
                    guard let tweet = try? snapshot?.data(as: Tweet.self)  else { return }
                    reTweetedTweets.append(tweet)
                    completion(reTweetedTweets)
                }
            }
        }
    }
    
}
