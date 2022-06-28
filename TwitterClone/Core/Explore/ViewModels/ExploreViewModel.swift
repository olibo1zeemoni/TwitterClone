//
//  ExploreViewModel.swift
//  TwitterClone
//
//  Created by Olibo moni on 21/06/2022.
//

import Foundation

class ExploreViewModel: ObservableObject {
    let service = UserService()
    @Published var users = [User]()
    @Published var searchText = ""
    
    var searchableUsers: [User] {
        if searchText.isEmpty {
            return users }
        else if searchText.hasPrefix("@") {
            
            return users.filter{ $0.username.localizedCaseInsensitiveContains(searchText.dropFirst().trimmingCharacters(in: .whitespaces))  }
                
        } else {
            return users.filter{ $0.username.localizedCaseInsensitiveContains(searchText.trimmingCharacters(in: .whitespaces)) || $0.fullname.localizedCaseInsensitiveContains(searchText.trimmingCharacters(in: .whitespaces)) }
        }
    }
    
    init(){
        fetchUsers()
    }
    
    func fetchUsers() {
        service.fetchUsers { users in
            self.users = users
        }
    }
    

}
