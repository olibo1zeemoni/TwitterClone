//
//  MessageViewModel.swift
//  TwitterClone
//
//  Created by Olibo moni on 25/06/2022.
//
import Firebase
import Foundation
import SwiftUI
@MainActor
class MessageViewModel: ObservableObject {
    
    @Published var users = [User]()
    @Published var messages = [Message]()
    let service = MessageService()
    let userService = UserService()
 
    
    init(){
        fetchRecentMessages()
      
    }
  
    func fetchRecentMessages() {
        
        service.fetchRecentMessages { messages in
            self.messages = messages
           
          
            for message in messages {
                let id = message.receiverUid
               // print(messages[i].user)
                self.userService.fetchUser(withUid: id) { user in
                    var user = user
                    user.recentMessage = message
                    self.users.append(user)
                   
                }
            }
        
        }
    }
    
//    func assignRecentMessage(){
//        DispatchQueue.main.asyncAfter(deadline: .now() + 1) { [self] in
//            for i in 0..<users.count {
//                for message in messages {
//                    if message.receiverUid == users[i].id {
//                        users[i].recentMessage = message
//                    }
//                }
//
//            }
//        }
//    }


}




//        for index in 0..<users.count {
//            let id = users[index].id
//            service.fetchlastMessage(forUId: id!) { message in
//                self.users[index].lastMessage = message
//            }
//        }
