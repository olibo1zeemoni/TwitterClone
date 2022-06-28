//
//  MessageBubbleView.swift
//  TwitterClone
//
//  Created by Olibo moni on 25/06/2022.
//

import SwiftUI
import Firebase

struct MessageBubbleView: View {
    var message: Message
    
    @State private var showTime = false
    
    
    var body: some View {
        VStack(alignment: message.isRecipient ? .leading : .trailing) {
            HStack {
                Text(message.caption)
                    .font(.system(size: 14, weight: .regular, design: .rounded))
                    .padding(.horizontal, 10)
                    .padding(.vertical, 7)
                    .background(message.isRecipient ? Color(.systemGray6) : Color("twitter"))
                    .foregroundColor(message.isRecipient ? .black: .white)
                    .clipShape(message.isRecipient ? RoundedShape(corners: [.topLeft, .topRight, .bottomRight]) : RoundedShape(corners: [.topLeft, .topRight, .bottomLeft]))
            }
            .frame(maxWidth: 300, alignment: message.isRecipient ? .leading : .trailing)
            .onTapGesture {
                showTime.toggle()
            }
            
            if showTime {
                Text("\(message.timestamp.dateValue().formatted(date: .omitted, time: .shortened))")
                    .font(.caption2)
                    .foregroundColor(.gray)
                    .padding(message.isRecipient ? .leading : .trailing, 25)
            }
        }
        .frame(maxWidth: .infinity, alignment: message.isRecipient ? .leading : .trailing)
        .padding(message.isRecipient ? .leading : .trailing)
        .padding(.horizontal, 10)
    }
}

struct MessageBubbleView_Previews: PreviewProvider {
    static var previews: some View {
        MessageBubbleView(message: Message.example)
    }
}
