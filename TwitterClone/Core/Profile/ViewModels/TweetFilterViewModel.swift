//
//  TweetFilterViewModel.swift
//  TwitterClone
//
//  Created by Olibo moni on 19/06/2022.
//

import Foundation

enum TweetFilterViewModel: Int, CaseIterable {
    case tweets, replies, likes
    
    var title: String {
        switch self {
        case .tweets: return "Tweets"
        case .replies: return "Replies"
        case .likes: return "Likes"
        }
    }
}
