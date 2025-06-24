//
//  ImagePickerScreen.swift
//  DocuGuard
//
//  Created by Raju Singh on 21/06/25.
//

import SwiftUI

struct ImagePickerScreen: View {
    @StateObject private var viewModel = ImagePickerViewModel()
    
    var body: some View {
        VStack(spacing: 20) {
            if let image = viewModel.selectedImage {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
                    .frame(height: 300)
                    .cornerRadius(12)
            } else {
                Text("No image selected")
                    .foregroundColor(.gray)
            }
            
            HStack {
                Button("Pick from Gallery") {
                    viewModel.showGallery()
                }
                Button("Capture Photo") {
                    viewModel.showCamera()
                }
            }
            .buttonStyle(.borderedProminent)
        }
        .sheet(isPresented: $viewModel.isShowingPicker) {
            ImagePicker(sourceType: viewModel.pickerSource, image: $viewModel.selectedImage)
        }
        .padding()
        .navigationTitle("Image Picker")
    }
}


#Preview {
    ImagePickerScreen()
}
