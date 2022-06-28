//
//  User.swift
//  TwitterClone
//
//  Created by Olibo moni on 20/06/2022.
//
import Firebase
import FirebaseFirestoreSwift

struct User: Identifiable, Decodable {
    @DocumentID var id: String?
    let username: String
    let email: String
    let fullname: String
    let profileImageUrl: String
    
    var recentMessage: Message?
    
    var isCurrentUser: Bool {
        return Auth.auth().currentUser?.uid == id 
    }
    
  
    
    static var example = User(username: "moni", email: "moni@gmail.com", fullname: "moni Olibo", profileImageUrl: "jfkldjflkdjfdlkjfkdfnjdlfj.com")
}
