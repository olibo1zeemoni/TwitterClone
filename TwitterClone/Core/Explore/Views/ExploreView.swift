//
//  ExploreView.swift
//  TwitterClone
//
//  Created by Olibo moni on 19/06/2022.
//

import SwiftUI

struct ExploreView: View {
    @StateObject var viewModel = ExploreViewModel()
   @State private var text = "Search Twitter"
    
    var body: some View {
            VStack {
                SearchBar(text: $viewModel.searchText, placeHolder: $text)
                ScrollView {
                    LazyVStack {
                        ForEach(viewModel.searchableUsers, id:\.id) { user in
                            NavigationLink {
                                ProfileView(user: user)
                            } label: {
                                UserRowView(user: user)
                            }

                        }
                    }
                }
            }
            
            //.navigationTitle("Explore")
            .navigationBarTitleDisplayMode(.inline)
    }
}

struct ExploreView_Previews: PreviewProvider {
    static var previews: some View {
        ExploreView()
    }
}
