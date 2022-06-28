//
//  MainTabView.swift
//  TwitterClone
//
//  Created by Olibo moni on 19/06/2022.
//

import SwiftUI

struct MainTabView: View {
    @State private var selectedIndex = 0
    
    var body: some View {
        TabView(selection: $selectedIndex) {
            FeedView()
                .onTapGesture {
                    self.selectedIndex = 0
                }
                .tabItem {
                    Image(systemName: "house")
                        .renderingMode(.template)
                }.tag(0)
            
            ExploreView()
                .onTapGesture {
                    self.selectedIndex = 1
                }
                .tabItem {
                    Image(systemName: "magnifyingglass")
                        .renderingMode(.template)
                }.tag(1)
            
            NotificationView()
                .onTapGesture {
                    self.selectedIndex = 2
                }
                .tabItem {
                    Image(systemName: "bell")
                        .renderingMode(.template)
                }.tag(2)
            
            MessagesView()
                .onTapGesture {
                    self.selectedIndex = 3
                }
                .tabItem {
                    Image(systemName: "envelope")
                        .renderingMode(.template)
                }.tag(3)
        }
        .accentColor(Color("twitter"))
        .navigationTitle(navTitle)
    }
    var navTitle: String {
        switch selectedIndex {
        case 1:
            return "Explore"
        case 2:
            return "Notification"
        case 3:
            return "Messages"
        default:
            return "Home"
        }
    }
}

struct MainTabView_Previews: PreviewProvider {
    static var previews: some View {
        MainTabView()
            .environmentObject(FeedViewModel())
    }
}
