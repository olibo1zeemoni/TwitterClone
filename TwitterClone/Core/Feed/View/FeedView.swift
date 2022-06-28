//
//  FeedView.swift
//  TwitterClone
//
//  Created by Olibo moni on 19/06/2022.
//

import SwiftUI

struct FeedView: View {
    @State private var showReloadButton = false
    @State private var showNewTweet = false
    @EnvironmentObject var viewModel : FeedViewModel
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    @State private var counter = 0
    @State private var dragNumber = 0
    
    

    
    var body: some View {
        ZStack(alignment: .topLeading) {
            ZStack(alignment: .bottomTrailing) {
                ScrollView {
                    LazyVStack {
                        ForEach(viewModel.tweets) { tweet in
                            TweetRowView(tweet: tweet)
                        }
                    }

                }
                

                
                Button {
                    showNewTweet.toggle()
                } label: {
                    Circle()
                        .fill(Color("twitter"))
                        .frame(width: 54, height: 54)
                        .overlay(Image(systemName: "plus")
                            .font(.title2)
                            .foregroundColor(.white))
                        
                }
                //.opacity(0.9)
                .padding()
                .fullScreenCover(isPresented: $showNewTweet) {
                    NewTweetView()
                }
            }
            
           // .navigationBarHidden(showReloadButton)
            
            .navigationBarTitleDisplayMode(.inline)
            
            Button {
                //reload tweets
                viewModel.fetchTweets()
                self.showReloadButton = false
            }label: {
                HStack(spacing: 5){
                    
                    Image(systemName: "arrow.up")
                        .font(.caption)
                        .padding(.leading, 10)
                        
                    
                    Circle()
                        .fill(.red)
                        .frame(width: 20, height: 20)
                        .offset(x: 10, y: 0)
                        
                        
                    Circle()
                        .fill(.green)
                        .frame(width: 20, height: 20)
                        .offset()
                        .clipShape(Circle(), style: FillStyle())
             
                    
                    Text("Tweeted")
                        .font(.subheadline)
                        
                }
                .foregroundColor(.white)
                .padding(5)
                .background(Color("twitter"))
                .clipShape(Capsule())
                    
            }
            .offset(x: UIScreen.main.bounds.width / 3, y: showReloadButton ? 4 : -120)
           
        }
        .onReceive(timer) { time in
            counter += 1
            if counter.isMultiple(of: 20) {
                self.showReloadButton = true
            }
            
          
        }
        

    }
    
   
    
}

struct FeedView_Previews: PreviewProvider {
    static var previews: some View {
        FeedView()
            .environmentObject(FeedViewModel())
    }
        
}
