//
//  UploadTweetViewModel.swift
//  TwitterClone
//
//  Created by Olibo moni on 21/06/2022.
//

import Foundation

class UploadTweetViewModel: ObservableObject {
    @Published var didUploadTweet = false
    let service = TweetService()
    
    
    func uploadTweet(withCaption caption: String) {
        service.uploadTweet(caption: caption) { success in
            if success {
                self.didUploadTweet = true
                //dismiss view
            } else {
                //show error message to user
            }
            
        }
    }
}
