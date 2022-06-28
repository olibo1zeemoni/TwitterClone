//
//  ChatViewModel.swift
//  TwitterClone
//
//  Created by Olibo moni on 26/06/2022.
//

import Foundation

@MainActor
class ChatViewModel: ObservableObject {
    
    @Published var messages = [Message]()
    @Published var lastMessageId: String = ""
    let service = MessageService()
    let userService = UserService()
    let recipient: User
    
    
    init(recipient: User){
        self.recipient = recipient
        fetchMessage()
    }
    

    
    func fetchMessage(){
        
        guard let id = recipient.id else { return }
        service.fetchMessage(forUId: id) { messages in
            self.messages = messages
            if (messages.last?.id) != nil {
                self.lastMessageId = messages.last!.id!
            }
        }
    }
    
    func sendMessage(caption: String) {
        
        guard let receiverUid = recipient.id else { return }
        
        service.sendMessage(caption: caption, receiverUid: receiverUid) { success in
            if success {
                print("DEBUG: \(success)")
            }
        }
    }
    
    
}
