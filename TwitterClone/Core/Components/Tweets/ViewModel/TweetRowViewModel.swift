//
//  TweetRowViewModel.swift
//  TwitterClone
//
//  Created by Olibo moni on 22/06/2022.
//

import Foundation

class TweetRowViewModel : ObservableObject {
   @Published var tweet: Tweet
    private let service = TweetService()
    
    init(tweet: Tweet){
        self.tweet = tweet
        checkIfUserLikedTweet()
        checkIfUserRetweetedTweet()
        
    }
    
    func likeTweet(){
        service.likeTweet(tweet: tweet) { 
            self.tweet.didLike = true
        }
    }
    func checkIfUserLikedTweet() {
        service.checkIfUserLikedTweet(tweet) { didLike in
            if didLike {
                self.tweet.didLike = true
            }
        }
    }
    
    func unlikeTweet(){
        service.unlikeTweet(tweet) {
            self.tweet.didLike = false
        }
    }
    
    func reTweet(){
        service.retweet(tweet: tweet) {
            self.tweet.didRetweet = true
        }
    }
    func checkIfUserRetweetedTweet() {
        service.checkIfUserRetweetedTweet(tweet) { didRetweet in
            if didRetweet {
                self.tweet.didRetweet = true
            }
        }
    }
    
    func unReTweet(){
        service.unRetweet(tweet) {
            self.tweet.didRetweet = false
        }
    }
    
}
