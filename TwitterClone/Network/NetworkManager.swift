//
//  NetworkManager.swift
//  TwitterClone
//
//  Created by Olibo moni on 22/06/2022.
//

import Foundation
import Network
import SwiftUI

class NetworkManager: ObservableObject {
    let monitor = NWPathMonitor()
    let queue = DispatchQueue(label: "NetworkManager")
    @Published var isConnected = true
    @Published var notConnected = false
    
    var connectionDescription: String {
        if isConnected {
            return "Internet connection looks good!"            
        } else {
            return "It looks like you're not connected to the internet"
        }
    }
    
    var image: Image {
        isConnected ? Image(systemName: "wifi") : Image(systemName: "wifi.slash")
    }
    
    init() {
        monitor.pathUpdateHandler = { path in
            DispatchQueue.main.async {
                self.isConnected = path.status == .satisfied
                self.notConnected = path.status != .satisfied
                
            }
        }
        monitor.start(queue: queue)
    }
}
