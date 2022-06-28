//
//  NewTweetView.swift
//  TwitterClone
//
//  Created by Olibo moni on 19/06/2022.
//

import SwiftUI
import Kingfisher

struct NewTweetView: View {
    @State private var caption = ""
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var authViewModel: AuthViewModel
    @StateObject var viewModel = UploadTweetViewModel()
    @EnvironmentObject var feedViewModel: FeedViewModel
    @EnvironmentObject var networkManager: NetworkManager
    
    @State private var showTweetErrorAlert = false
    
    var disable: Bool {
         caption.isEmpty
    }
    
    var body: some View {
        VStack {
            HStack {
                Button {
                    dismiss()
                }label: {
                    Text("Cancel")
                        .foregroundColor(Color(.systemBlue))
                }
                
                Spacer()
                
                Button {
                    if networkManager.isConnected {
                        viewModel.uploadTweet(withCaption: caption)
                    } else {
                         showTweetErrorAlert = true
                    }
                    
                    
                } label: {
                    Text("Tweet")
                        .bold()
                        .padding(.horizontal)
                        .padding(.vertical, 8)
                        .background(disable ? .gray.opacity(0.5) : Color(.systemBlue))
                        .foregroundColor(.white)
                        .clipShape(Capsule())
                }
                .disabled(disable)

            }
            .padding()
            HStack(alignment: .top) {
                if let user = authViewModel.currentUser {
                    KFImage(URL(string: user.profileImageUrl))
                        .resizable()
                        .scaledToFill()
                        .clipShape(Circle())
                        .frame(width: 64, height: 64)
                }
                
                    
                
                TextArea("What's happening?", text: $caption)
            }
            .padding()
        }
        .onReceive(viewModel.$didUploadTweet, perform: { success in
            if success {
                feedViewModel.fetchTweets()                
                dismiss()
                
            } else {
               // showTweetErrorAlert = true
                
               
            }
        })
        .alert("Unable to send tweets at this time", isPresented: $networkManager.notConnected ) {
            Button("Try again") { }
        } message: {
            Text("Please check your connection and try again")
        }
        .alert("Failed to send tweet", isPresented: $showTweetErrorAlert ) {
            Button("Try again") { }
        } message: {
            Text("Tweet not sent, please try again")
        }
    }
    
    var showalert: Binding<Bool> {
        return $networkManager.isConnected 
    }
}

struct NewTweetView_Previews: PreviewProvider {
    static var previews: some View {
        NewTweetView()
            .environmentObject(FeedViewModel())
            .environmentObject(NetworkManager())
            .environmentObject(AuthViewModel())
    }
}
