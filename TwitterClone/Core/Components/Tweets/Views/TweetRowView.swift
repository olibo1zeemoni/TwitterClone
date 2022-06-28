//
//  TweetRowView.swift
//  TwitterClone
//
//  Created by Olibo moni on 19/06/2022.
//
import Firebase
import SwiftUI
import Kingfisher

struct TweetRowView: View {
    @State private var animationAmount = 1
    @ObservedObject var viewModel : TweetRowViewModel
    @State private var showHeart = false
    
    init(tweet: Tweet){
        self._viewModel = ObservedObject(initialValue:  TweetRowViewModel(tweet: tweet))

    }
    
    var body: some View {
        VStack {
            VStack {
                //profile image + user + tweet
                if let user = viewModel.tweet.user {
                    HStack(alignment: .top, spacing: 12) {
                        KFImage(URL(string: user.profileImageUrl))
                            .resizable()
                            .scaledToFill()
                            .clipShape(Circle())
                            .frame(width: 56, height: 56)
                            .foregroundColor(Color(.systemBlue))
                        
                        // user info & tweet caption
                        VStack(alignment: .leading, spacing: 10) {
                            VStack(alignment: .leading) {
                                //user info
                                HStack {
                                    Text(user.fullname)
                                        .font(.subheadline).bold()
                                    
                                    Text("@\(user.username)")
                                        .foregroundColor(.gray)
                                        .font(.caption)
                                    
                                    Text("2w")
                                        .foregroundColor(.gray)
                                        .font(.caption)
                                }
                                //tweet caption
                                
                                Text(viewModel.tweet.caption)
                                    .font(.subheadline)
                                    .multilineTextAlignment(.leading)
                                
                                
                            }
                            .padding(.horizontal, 0)
                            
                            //action buttons
                            HStack {
                                Button {
                                    //comment
                                } label: {
                                    Image(systemName: "bubble.left")
                                        .font(.subheadline)
                                }
                                
                                Spacer()
                                
                                Button {
                                    //retweet
                                    viewModel.tweet.didRetweet ?? false  ? viewModel.unReTweet() : viewModel.reTweet()
                                } label: {
                                    Image(systemName: "arrow.2.squarepath")
                                        .font(.subheadline)
                                        .foregroundColor(viewModel.tweet.didRetweet ?? false ? .green : .gray)
                                }
                                
                                Spacer()
                                
                                
                                Button {
                                    //like tweet
                                    withAnimation {
                                        viewModel.tweet.didLike ?? false ? viewModel.unlikeTweet() : viewModel.likeTweet()
                                        animationAmount += 1
                                        showHeart.toggle()
                                    }
                                    
                                } label: {
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
                                        
                                        
                                        Image(systemName: viewModel.tweet.didLike ?? false ? "heart.fill" : "heart")
                                            .foregroundColor(viewModel.tweet.didLike ?? false ? .pink : .gray)
                                            .animation(.interactiveSpring(), value: animationAmount)
                                    }
                                    
                                }
                                
                                Spacer()
                                
                                Button {
                                    //bookmark
                                } label: {
                                    Image(systemName: "bookmark")
                                        .font(.subheadline)
                                }
                                Spacer()
                            }
                            
                            .foregroundColor(.gray)
                        }
                    }
                }
                
                
            }
            .padding()
            
            Divider()
        }
        
       
    }
    
  
}

struct TweetRowView_Previews: PreviewProvider {
    static var previews: some View {
        TweetRowView(tweet: Tweet(caption: "Thank God", timestamp: Timestamp(), uid: NSUUID().uuidString, likes: 4, retweets: 5))
    }
}

//extension TweetRowView {
//    var likeView: some View {
//
//
//    }
//}
