//
//  ProfileViewModel.swift
//  TwitterClone
//
//  Created by Olibo moni on 21/06/2022.
//

import Foundation

class ProfileViewModel: ObservableObject {
    @Published var tweets = [Tweet]()
    @Published var likedTweets = [Tweet]()
    @Published var retweets = [Tweet]()
    private let service = TweetService()
    private let userService = UserService()
    let user: User
    
    var actionButtonTitle: String {
        return user.isCurrentUser ? "Edit Profile" : "Follow"
    }
    
    init(user: User) {
        self.user = user
        self.fetchUserTweets()
        self.fetchLikedTweets()
        self.fetchRetweets()
    }
    
    func tweets(forFilter filter: TweetFilterViewModel) -> [Tweet] {
        switch filter {
        case .tweets:
            return self.tweets
        case .replies:
            return self.tweets
        case .likes:
            //let likesAndRetweets = likedTweets.append(contentsOf: retweets) as [Tweet]
            return self.likedTweets
        }
    }
    
    func fetchUserTweets() {
        guard let uid = user.id else { return }
        service.fetchTweets(forUId: uid) { tweets in
            self.tweets = tweets
            
            for i in 0..<tweets.count {
                self.tweets[i].user = self.user
            }
        }
    }
    
    func fetchLikedTweets(){
        guard let uid = user.id else { return }
        service.fetchLikedTweets(forUid: uid) { tweets in
            self.likedTweets = tweets
            
            for i in 0..<tweets.count {
                let uid = tweets[i].uid
                
                self.userService.fetchUser(withUid: uid) { user in
                    self.likedTweets[i].user = user
                }
            }
        }
    }
    
    func fetchRetweets(){
        guard let uid = user.id else { return }
        service.fetchReTweets(forUid: uid) { tweets in
            self.retweets = tweets
            
            for i in 0..<tweets.count {
                let uid = tweets[i].uid
                
                self.userService.fetchUser(withUid: uid) { user in
                    self.retweets[i].user = user
                }
            }
        }
    }
    
}
