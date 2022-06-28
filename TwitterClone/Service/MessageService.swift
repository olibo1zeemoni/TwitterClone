//
//  MessageService.swift
//  TwitterClone
//
//  Created by Olibo moni on 25/06/2022.
//

import Foundation
import Firebase

struct MessageService {
    func sendMessage(caption: String, receiverUid: String, completion: @escaping(Bool) -> Void) {
        guard let senderUid = Auth.auth().currentUser?.uid else { return }
        
        let data: Dictionary<String, Any> = ["senderUid": senderUid,
                                             "receiverUid": receiverUid,
                                             "caption": caption,
                                             "timestamp": Timestamp(date: Date())]
        
        
        let db = Firestore.firestore().collection("messages")
        
        let rmDB = Firestore.firestore().collection("recent-messages").document(senderUid).collection("messages").document(receiverUid)
        
        let data2: Dictionary<String, Any> = ["senderUid": senderUid,
                                              "receiverUid": receiverUid,
                                              "caption": caption,
                                              "timestamp": Timestamp(date: Date()) ]
            
        db.document().setData(data, merge: false) { error in
            
            if let error = error {
                print("DEBUG: Failed to send message with error \(error.localizedDescription)")
                completion(false)
                return
            } else {
                rmDB.setData(data2)
                    completion(true)
            }
             
        }
    }
    

///  .whereField("receiverUid", isEqualTo: <#T##Any#>)
///   .order(by: "timestamp", descending: true)
///   .addSnapshotListener { snapshot, _ in

    
    
    //user uid passed in to fetch user info
    func fetchMessage(forUId uid: String, completion:@escaping([Message]) -> Void) {
        Firestore.firestore().collection("messages")
            .whereField("receiverUid", isEqualTo: uid)
            .addSnapshotListener { snapshot, _ in
                guard let documents = snapshot?.documents else { return }
                let messages = documents.compactMap ({ try? $0.data(as: Message.self) })
                completion(messages.sorted(by: { $0.timestamp.dateValue() < $1.timestamp.dateValue() }) )
        }
    }
    
    func fetchRecentMessages(completion: @escaping([Message]) ->Void) {
        
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        Firestore.firestore().collection("recent-messages").document(uid).collection("messages")
            .order(by: "timestamp", descending: true)
            .addSnapshotListener { snapshot, _ in
                guard let documents = snapshot?.documents else { return }
                let messages = documents.compactMap ({ try? $0.data(as: Message.self) })
                
                completion(messages)
            }
    }
    
  
   
    
}
