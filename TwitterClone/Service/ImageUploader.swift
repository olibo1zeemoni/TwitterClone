//
//  ImageUploader.swift
//  TwitterClone
//
//  Created by Olibo moni on 20/06/2022.
//

import Firebase
import FirebaseStorage
import UIKit


struct ImageUploader {
    
    static func upload(image: UIImage, completion: @escaping(String) -> Void) {
        guard let imageData = image.jpegData(compressionQuality: 0.5) else { return }
        
        let filename = NSUUID().uuidString
        let ref = Storage.storage().reference(withPath: "/profile_image/\(filename)")
        
        ref.putData(imageData, metadata: nil) { _, error in
            if let error = error {
                print("DEBUG: Failed to upload image with error: \(error.localizedDescription)")
                return
            }
            
            ref.downloadURL { imageURL, _ in
                guard let imageUrl = imageURL?.absoluteString else { return }
                completion(imageUrl)
            }
        }
    }
    
}
