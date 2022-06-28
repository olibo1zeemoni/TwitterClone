//
//  FeedViewModel.swift
//  TwitterClone
//
//  Created by Olibo moni on 21/06/2022.
//

import Foundation
@MainActor
class FeedViewModel: ObservableObject {
//    static func == (lhs: FeedViewModel, rhs: FeedViewModel) -> Bool {
//        lhs.tweets == rhs.tweets
//    }
    
    @Published var tweets = [Tweet]()
    let service = TweetService()
    let userService = UserService()
    
    init(){
        fetchTweets()
        
    }
    
    func fetchTweets() {
        service.fetchTweets { tweets in
            self.tweets = tweets
            
            for i in 0..<tweets.count {
                let uid = tweets[i].uid
                
                self.userService.fetchUser(withUid: uid) { user in
                    self.tweets[i].user = user
                }
            }
            
        }
    }
    
}
