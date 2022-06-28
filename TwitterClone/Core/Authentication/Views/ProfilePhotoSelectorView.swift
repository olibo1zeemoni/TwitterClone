//
//  ProfilePhotoSelectorView.swift
//  TwitterClone
//
//  Created by Olibo moni on 20/06/2022.
//

import SwiftUI

struct ProfilePhotoSelectorView: View {
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var viewModel: AuthViewModel
    
    @State private var sourceType: UIImagePickerController.SourceType = .photoLibrary
    @State private var inputImage: UIImage?
    @State private var showConfirmation = false
    @State private var showImagePicker = false
    
    var body: some View {
        NavigationView {
            VStack {
                AuthHeaderView(title1: "Setup account", title2: "Add a profile photo")
                
                Button {
                    print("Pick image here")
                    showConfirmation = true
                    
                } label: {
                    if inputImage != nil {
                        Image(uiImage: inputImage!)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 250)
                            .clipShape(Circle())
                            .overlay(Circle().stroke(.blue, lineWidth: 2)
                                .shadow(color: .black, radius: 5))
                            .padding(.top, 44)
                            
                                               
                    } else {
                        Image(systemName: "photo.circle")
                            .resizable()
                            .imageStyle()
                        
                    }
                    
                }
                
                Spacer()
                    .frame(height: 30)
                
                Button{
                    //continue to main Feed
                    viewModel.uploadProfileImage(inputImage!)
                }label:{
                    Text("Continue")
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(width:340,height:50)
                        .background(Color(.systemBlue))
                        .clipShape(Capsule())
                        .padding()
                }
                .disabled(disableContinue)
                .shadow(color: .gray.opacity(0.5), radius: 10, x: 0, y: 0)
                
                Spacer()
            }
            .ignoresSafeArea()
            .confirmationDialog("Photo Source", isPresented: $showConfirmation) {
                Button("Photos") {
                    showImagePicker = true }
                Button("Camera") {
#if targetEnvironment(simulator)
                    //do nothing
#else
                    sourceType = .camera
#endif
                    showImagePicker = true }
                Button("Cancel", role: .cancel) { }
            } message: {
                Text("Select Image Source")
            }
            .sheet(isPresented: $showImagePicker) {
                ImagePicker(image: $inputImage, sourceType: $sourceType)
            }
        }
    }
    
    var disableContinue: Bool {
        guard inputImage != nil else { return true }
        return false
    }
}



struct ProfilePhotoSelectorView_Previews: PreviewProvider {
    static var previews: some View {
        ProfilePhotoSelectorView()
    }
}


private struct ProfileImageModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            //.resizable()
            .scaledToFill()
            .frame(width: 180, height: 180)
            .padding(.top, 44)
    }
}
 
extension View {
    func imageStyle() -> some View {
        modifier(ProfileImageModifier())
    }
}
