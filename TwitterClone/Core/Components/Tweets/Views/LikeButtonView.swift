//
//  LikeButtonView.swift
//  TwitterClone
//
//  Created by Olibo moni on 23/06/2022.
//

import SwiftUI

struct LikeButtonView: View {
//    @State private var showStrokeBorder = false
//    @State private var showSplash = false
//    @State private var showSplashTilted = false
   @State  var showHeart: Bool
    @State private var animationAmount = 1
    
   
    
    var body: some View {
        Button {
            showHeart.toggle()
        }label: {
            ZStack {
                
                Circle()
                    .strokeBorder(lineWidth: showHeart ? 1 : 35/2, antialiased: false)
                    .opacity(showHeart ? 0 : 1)
                    .frame(width: 35, height: 35)
                    .foregroundColor(.purple)
                    .scaleEffect(showHeart ? 1 : 0)
                    .animation(Animation.easeInOut(duration: 0.5), value: animationAmount)
                
                
                
                Image("splash") // Splash
                    .resizable()
                    .opacity(showHeart ? 0 : 1)
                    .frame(width: 48, height: 48)
                    .scaleEffect(showHeart ? 1 : 0)
                    .animation(Animation.easeInOut(duration: 0.5), value: animationAmount)
                
                
                
                
                Image("splash_tilted") // Splash: tilted
                    .resizable()
                    .opacity(showHeart ? 0 : 1)
                    .frame(width: 50, height: 50)
                    .scaleEffect(showHeart ? 1.1 : 0)
                    .scaleEffect(1.1)
                    .animation(Animation.easeOut(duration: 0.5).delay(0.1), value: animationAmount)
                
                
                
                
                Image(systemName: showHeart ? "heart.fill": "heart")
                    .foregroundColor(showHeart ? .pink : .gray)
                    .scaleEffect(showHeart ? 1.2 : 1)
                    .onTapGesture {
    //                    withAnimation(.easeInOut(duration: 0.5).delay(0.1)) { showHeart.toggle()
    //                        showSplash.toggle()
    //                        showHeart.toggle()
    //                    }
                        withAnimation(.easeIn(duration: 0.2).repeatCount(1, autoreverses: true)) {
                            showHeart.toggle()
                        }
                        
                    }
                    .animation(.interactiveSpring(), value: animationAmount)
                
            }
        }
        
    }
    
    init(showHeart: Bool) {
        self.showHeart = showHeart
    }
}

struct LikeButtonView_Previews: PreviewProvider {
    static var previews: some View {
        LikeButtonView(showHeart: true)
    }
}
