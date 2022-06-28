//
//  SelectRecipientView.swift
//  TwitterClone
//
//  Created by Olibo moni on 25/06/2022.
//

import SwiftUI

struct SelectRecipientView: View {
    @ObservedObject var exploreVM = ExploreViewModel()
    //@State private var searchText = ""
    @State private var placeHolder = "Search Messages"
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationView{
        VStack {
            HStack {
                SearchBar(text: $exploreVM.searchText, placeHolder: $placeHolder)
                
                Button("cancel"){
                    dismiss()
                }
            }
            .padding(.horizontal, 5)
                
                ScrollView {
                    LazyVStack {
                        ForEach(exploreVM.searchableUsers, id:\.id) { user in
                            NavigationLink {
                                ChatView(recipient: user)
                            } label: {
                                UserRowView(user: user)
                            }

                        }
                    }
                }
            }

        .navigationBarHidden(true)
    }
        

    }
}

struct SelectRecipientView_Previews: PreviewProvider {
    static var previews: some View {
        SelectRecipientView()
    }
}
