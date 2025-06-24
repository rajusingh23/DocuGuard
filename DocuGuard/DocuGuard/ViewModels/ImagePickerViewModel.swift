//
//  ImagePickerViewModel.swift
//  DocuGuard
//
//  Created by Raju Singh on 21/06/25.
//

import Foundation
import UIKit

class ImagePickerViewModel: ObservableObject {
    @Published var selectedImage: UIImage?
    @Published var isShowingPicker = false
    @Published var pickerSource: UIImagePickerController.SourceType = .photoLibrary
    
    func showGallery() {
        pickerSource = .photoLibrary
        isShowingPicker = true
    }
    
    func showCamera() {
        pickerSource = .camera
        isShowingPicker = true
    }
}


