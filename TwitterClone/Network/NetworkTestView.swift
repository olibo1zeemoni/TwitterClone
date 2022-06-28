//
//  NetworkTestView.swift
//  TwitterClone
//
//  Created by Olibo moni on 22/06/2022.
//

import SwiftUI

struct NetworkTestView: View {
    @EnvironmentObject var networkManager: NetworkManager
    var body: some View {
        ZStack {
            Color.blue
            VStack(spacing: 30) {
                networkManager.image
                    .resizable()
                    .scaledToFill()
                    .frame(width: 100, height: 100)
                
                
                Text(networkManager.connectionDescription)
                    .font(.system(size: 18))
                if !networkManager.isConnected {
                    Button{
                        print("Handle action ..")
                    } label: {
                        Text("Retry")
                            .padding()
                            .font(.headline)
                            .foregroundColor(Color(.systemBlue))
                            .frame(width:140)
                            .background(Color.white)
                            .clipShape(Capsule())
                            .padding()
                    }
                }
             
            }
            .foregroundColor(.white)
            
            
        }
        .ignoresSafeArea()
    }
}

struct NetworkTestView_Previews: PreviewProvider {
    static var previews: some View {
        NetworkTestView()
    }
}
