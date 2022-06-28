//
//  NewMessage.swift
//  TwitterClone
//
//  Created by Olibo moni on 25/06/2022.
//

import SwiftUI
import Kingfisher


struct ChatView: View {
 
    
    @StateObject private var viewModel : ChatViewModel
    @State private var caption = ""
  
    
    
    init(recipient: User){
        self._viewModel = StateObject(wrappedValue: ChatViewModel(recipient: recipient))
    }
    
    var body : some View {
        VStack{
            VStack {
                HStack(alignment: .center) {
                    Spacer()
                    VStack(spacing: 5) {
                        KFImage(URL(string: viewModel.recipient.profileImageUrl))
                            .resizable()
                            .scaledToFill()
                            .clipShape(Circle())
                            .frame(width: 24, height: 24)
                            .padding(.top, 5)
                        Text(viewModel.recipient.fullname)
                            .font(.caption).bold()
                    }
                    
                    
                    Spacer()
                    Image(systemName: "info.circle")
                }
                .frame(height: 80)
                .padding(.horizontal)
                .padding(.top, 20)
                .padding(.bottom, -10)
                ScrollViewReader { proxy in
                    ScrollView{
                        ForEach(viewModel.messages, id:\.id) { message in
                            MessageBubbleView(message: message)
                        }
                    }
                    .padding(.top,10)
                    .background(.white)
                    .onChange(of: viewModel.lastMessageId) { id in
                        withAnimation {
                            proxy.scrollTo(id, anchor: .bottom)
                        }
                    }
                
                }
                
                MessageFieldView(sendMessage: {
                    viewModel.sendMessage(caption: caption)
                }, message: $caption)
                    .padding()
                    .keyboardResponsive()
            }
            
        }
        .ignoresSafeArea()
        .background(.white)
        .navigationBarTitleDisplayMode(.inline)
    }
}
    

struct NewMessage_Previews: PreviewProvider {
    static var previews: some View {
        ChatView(recipient: User.example)
    }
}

//sendMessage: {
//viewModel.sendMessage(caption: caption)
//},


struct KeyboardResponsiveModifier: ViewModifier {
  @State private var offset: CGFloat = 0

  func body(content: Content) -> some View {
    content
      .padding(.bottom, offset)
      .onAppear {
        NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillShowNotification, object: nil, queue: .main) { notif in
          let value = notif.userInfo![UIResponder.keyboardFrameEndUserInfoKey] as! CGRect
          let height = value.height
            let bottomInset = UIApplication.shared.windows.first?.safeAreaInsets.bottom
            //UIApplication.shared.windows.first?.safeAreaInsets.bottom
            withAnimation {
                self.offset = height - (bottomInset ?? 0)
            }
        }

        NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillHideNotification, object: nil, queue: .main) { notif in
            withAnimation {
                self.offset = 0
            }
        }
    }
  }
}

extension View {
  func keyboardResponsive() -> ModifiedContent<Self, KeyboardResponsiveModifier> {
    return modifier(KeyboardResponsiveModifier())
  }
}

