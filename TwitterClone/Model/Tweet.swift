//
//  Tweet.swift
//  TwitterClone
//
//  Created by Olibo moni on 21/06/2022.
//

import FirebaseFirestoreSwift
import Firebase

struct Tweet: Identifiable, Decodable, Equatable {
    static func == (lhs: Tweet, rhs: Tweet) -> Bool {
       return lhs.id == rhs.id
    }
    
    @DocumentID var id: String?
    let caption: String
    let timestamp: Timestamp
    let uid: String
    var likes: Int
    var retweets: Int
    
    
    var user: User?
    var didLike: Bool? = false
    var didRetweet: Bool? = false
}
