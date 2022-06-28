//
//  TwitterCloneApp.swift
//  TwitterClone
//
//  Created by Olibo moni on 19/06/2022.
//

import SwiftUI
import Firebase

@main
struct TwitterCloneApp: App {
    
    @StateObject var viewModel = AuthViewModel()
    @StateObject var feedViewModel : FeedViewModel
    @StateObject var networkManager = NetworkManager()
    init() {
        FirebaseApp.configure()
        _feedViewModel = StateObject(wrappedValue: FeedViewModel())
    }
    
    var body: some Scene {
        WindowGroup {
            NavigationView {
                ContentView()
               // NetworkTestView()
            }
            .environmentObject(viewModel)
            .environmentObject(feedViewModel)
            .environmentObject(networkManager)
        }
    }
}
