//
//  MessagesView.swift
//  TwitterClone
//
//  Created by Olibo moni on 19/06/2022.
//

import SwiftUI
import Kingfisher

struct MessagesView: View {
    @State private var searchText = ""
    @State private var placeHolder = "Search Messages"
    @State private var showRecipient = false
    @StateObject private var viewModel : MessageViewModel
   // @ObservedObject var exploreViewModel: ExploreViewModel
   
    
    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            VStack(alignment: .leading) {
                SearchBar(text: $searchText, placeHolder: $placeHolder)
                ScrollView {
                    ForEach(viewModel.users, id:\.id) { user in
                            
                            NavigationLink {
                                ChatView(recipient: user)
                                
                            } label: {
                                HStack {
                                    KFImage(URL(string: user.profileImageUrl))
                                        .resizable()
                                        .scaledToFill()
                                        .frame(width: 54, height: 54)
                                        .clipShape(Circle())
                                    
                                    VStack(alignment: .leading, spacing: 5) {
                                        HStack(alignment: .top) {
                                            Text(user.fullname)
                                                .font(.body).bold()
                                            Text("@\(user.username)")
                                            
                                            Spacer()
                                            
                                            Text(user.recentMessage?.timestamp.dateValue().formatted(date: .numeric, time: .omitted) ?? Date().formatted(date: .numeric, time: .omitted) )
                                        }
                                        Text(user.recentMessage?.caption ?? "")
                                    }
                                }
                                .foregroundColor(.black)
                                .padding()
                            }
                        
                      
                        
                    }}
            }
            Button {
                showRecipient.toggle()
            } label: {
                Circle()
                    .fill(Color("twitter"))
                    .frame(width: 54, height: 54)
                    .overlay(Image(systemName: "envelope")
                        .font(.title2)
                        .foregroundColor(.white))
                    
                
            }
            
            .padding()
        }
        .fullScreenCover(isPresented: $showRecipient) {
            SelectRecipientView()
        }
    }
    init(){
        self._viewModel = StateObject(wrappedValue: MessageViewModel())
    }
//    init() {
//        self._exploreViewModel = ObservedObject(wrappedValue: ExploreViewModel())
//    }
}

struct MessagesView_Previews: PreviewProvider {
    static var previews: some View {
        MessagesView()
    }
}

