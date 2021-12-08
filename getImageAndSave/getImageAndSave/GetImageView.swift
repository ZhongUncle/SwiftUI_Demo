//
//  GetImageView.swift
//  getImageAndSave
//
//  Created by 钟宜江 on 2021/9/4.
//

import UIKit
import SwiftUI

struct ImagePicker: UIViewControllerRepresentable {
 
    @Environment(\.presentationMode) private var presentationMode
    let sourceType: UIImagePickerController.SourceType
    let onImagePicked: (UIImage) -> Void
 
    final class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
 
        @Binding private var presentationMode: PresentationMode
        private let sourceType: UIImagePickerController.SourceType
        private let onImagePicked: (UIImage) -> Void
 
        init(presentationMode: Binding<PresentationMode>,
             sourceType: UIImagePickerController.SourceType,
             onImagePicked: @escaping (UIImage) -> Void) {
            _presentationMode = presentationMode
            self.sourceType = sourceType
            self.onImagePicked = onImagePicked
        }
 
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            let uiImage = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
            onImagePicked(uiImage)
            presentationMode.dismiss()
 
        }
 
        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            presentationMode.dismiss()
        }
 
    }
 
    func makeCoordinator() -> Coordinator {
        return Coordinator(presentationMode: presentationMode,
                           sourceType: sourceType,
                           onImagePicked: onImagePicked)
    }
 
    func makeUIViewController(context: UIViewControllerRepresentableContext<ImagePicker>) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.sourceType = sourceType
        picker.delegate = context.coordinator
        return picker
    }
 
    func updateUIViewController(_ uiViewController: UIImagePickerController,
                                context: UIViewControllerRepresentableContext<ImagePicker>) {
 
    }
 
}

struct GetImageView: View {
    @State private var showImagePicker = false
    @State private var image: UIImage = UIImage()
    var body: some View {
        List{
            Button(action: {
                showImagePicker = true
            }, label: {
                Text("Button")
            })
            Image(uiImage: image)
                .frame(width: 200, height: 100)
                .fixedSize()
        }
        .sheet(isPresented: $showImagePicker) {
                    ImagePicker(sourceType: .photoLibrary) { image in
                        self.image = image
                    }
    }

        
    }
}

struct GetImageView_Previews: PreviewProvider {
    static var previews: some View {
        GetImageView()
    }
}
