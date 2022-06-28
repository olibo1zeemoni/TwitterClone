//
//  UserRowView.swift
//  TwitterClone
//
//  Created by Olibo moni on 19/06/2022.
//

import SwiftUI
import Kingfisher

struct UserRowView: View {
    let user: User
    
    var body: some View {
        HStack(spacing: 12) {
            KFImage(URL(string: user.profileImageUrl))
                .resizable()
                .scaledToFill()
                .clipShape(Circle())
                .frame(width: 56, height: 56)
            
            VStack(alignment: .leading, spacing: 4) {
                Text("@\(user.username)")
                    .font(.subheadline).bold()
                    .foregroundColor(.black)
                
                Text(user.fullname)
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
            
            Spacer()
        }
        .padding(.horizontal)
        .padding(.vertical, 4)
    }
}

struct UserRowView_Previews: PreviewProvider {
    static var previews: some View {
        UserRowView(user: User(id: NSUUID().uuidString, username: "onezeemoni", email: "", fullname: "Olibo Moni", profileImageUrl: "https://firebasestorage.googleapis.com:443/v0/b/twitterclone-f83a4.appspot.com/o/profile_image%2F4F5762D8-4A37-4081-9BB7-D3C711C593B4?alt=media&token=92d9e5b7-9d85-417d-90fb-49a4dcd9456c"))
    }
}
