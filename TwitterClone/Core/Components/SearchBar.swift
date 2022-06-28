//
//  SearchBar.swift
//  TwitterClone
//
//  Created by Olibo moni on 21/06/2022.
//

import SwiftUI

struct SearchBar: View {
    @Binding var text: String
    @Binding var placeHolder: String
        
    var body: some View {
        HStack {
            TextField("\(placeHolder)...", text: $text)
                .padding(8)
                .padding(.horizontal, 24)
                .background(Color(.systemGray6))
                .cornerRadius(8)
                .overlay(
                    HStack {
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(.gray)
                            .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                            .padding(.leading, 8)
                    }
                )
            
        }
        .padding(.horizontal, 4)
    }
}

struct SearchBar_Previews: PreviewProvider {
    static var previews: some View {
        SearchBar(text: .constant(""), placeHolder: .constant("Search here"))
            .previewLayout(.sizeThatFits)
    }
}