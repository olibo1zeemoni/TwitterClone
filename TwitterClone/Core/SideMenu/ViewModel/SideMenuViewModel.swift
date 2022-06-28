//
//  SideMenuViewModel.swift
//  TwitterClone
//
//  Created by Olibo moni on 19/06/2022.
//

import Foundation

enum SideMenuViewModel: Int, CaseIterable {
    case profile, lists, bookmarks, logout
    
    var title: String {
        switch self {
        case .profile:
            return "Profile"
        case .lists:
            return "Lists"
        case .bookmarks:
            return "Bookmarks"
        case .logout:
            return "Logout"
        }
    }
    
    var imageName: String {
        switch self {
        case .profile:
            return "person"
        case .lists:
            return "list.bullet"
        case .bookmarks:
            return "bookmark"
        case .logout:
            return "arrow.left.square"
        }
    }
}
