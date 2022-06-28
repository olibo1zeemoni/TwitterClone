//
//  Message.swift
//  TwitterClone
//
//  Created by Olibo moni on 25/06/2022.
//

import FirebaseFirestoreSwift
import Firebase
import Foundation

struct Message : Identifiable, Decodable {
    static func == (lhs: Message, rhs: Message) -> Bool {
        lhs.id == rhs.id
    }
    
    
    
    @DocumentID var id: String?
    let caption: String
    let timestamp: Timestamp
    let receiverUid: String
    let senderUid: String
    
     
    
    
    var isRecipient: Bool {
        let currentUser = Auth.auth().currentUser
        if currentUser?.uid == senderUid {
            return false
        } else {
            return true
        }
    }
    
static var example = Message(caption: "this is a message", timestamp: Timestamp(date: Date()), receiverUid: "jdjfkdjfiejfkdjkf", senderUid: "jfkejfoejfekfj")
    
    static var example1 = Message(caption: "test recent message", timestamp: Timestamp(date: Date().addingTimeInterval(86000)), receiverUid: "jdjfkdjfiejfkdjkf", senderUid: "jfkejfoejfekfj")
    
}























//extension Message {
//    
//    enum CodingKeys: String, CodingKey {
//        case id = "id"
//        case caption = "caption"
//        case timestamp = "timestamp"
//        case uid = "uid"
//        
//        case user
//    }
//    
//    
//    init(from decoder: Decoder) throws {
//        let values = try decoder.container(keyedBy: CodingKeys.self)
//         id = try values.decode(String.self, forKey: .id)
//         caption = try values.decode(String.self, forKey: .caption)
//         timestamp = try values.decode(Date.self, forKey: .timestamp)
//         uid = try values.decode(String.self, forKey: .uid)
//    }
//}
