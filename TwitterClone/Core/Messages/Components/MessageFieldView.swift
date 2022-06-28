//
//  MessageFieldView.swift
//  TwitterClone
//
//  Created by Olibo moni on 25/06/2022.
//

import SwiftUI

struct MessageFieldView: View {
    
     var sendMessage: ()->()
   
    @Binding var message: String
    var body: some View {
        HStack {
            // Custom text field created below
            Button {
                
            }label: {
                Image(systemName: "photo")
                    .font(.title)
                    .scaleEffect(0.8)
            }
            Button {
                
            }label: {
                Text("GIF")
                    .bold()
                    .padding(3)
                    .overlay(RoundedRectangle(cornerRadius: 5).stroke())
                    .scaleEffect(0.8)
                    
            }
            
        
                
                CustomTextField(placeholder: Text("Start a message"), text: $message)
                    .padding()
                    .frame(height: 35)
                    .disableAutocorrection(true)
                    .background(Color(.systemGray6))
                    .cornerRadius(50)
                    .foregroundColor(.black)
                

              
                
                

            Button {
                //send message
                sendMessage()
                message = ""
            } label: {
                Image(systemName: "paperplane")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 25, height: 25)
                    .foregroundColor(Color("twitter"))
                    .padding(2)
                    .rotationEffect(.degrees(40))
                    
            }
        }
        .foregroundColor(Color("twitter"))
        .padding()
        
        
        
        
    }
  
}

//struct MessageFieldView_Previews: PreviewProvider {
//
//    static var previews: some View {
//        MessageFieldView(message: .constant(""))
//    }
//}


struct CustomTextField: View {
    var placeholder: Text
    @Binding var text: String
    var editingChanged: (Bool)->() = { _ in }
    var commit: ()->() = { }

    var body: some View {
        ZStack(alignment: .leading) {
            // If text is empty, show the placeholder on top of the TextField
            if text.isEmpty {
                placeholder
                .opacity(0.5)
            }
            TextField("", text: $text, onEditingChanged: editingChanged, onCommit: commit)
                
        }
    }
}
