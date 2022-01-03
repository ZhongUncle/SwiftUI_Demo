//
//  ContentView.swift
//  ImageModify
//
//  Created by 钟宜江 on 2021/12/10.
//
import SwiftUI

struct ContentView: View {
    @State private var showImagePicker = false
    @State private var showCameraPicker = false
    @State private var image: UIImage = UIImage()
    var body: some View {
        VStack{
            HStack {
                Button(action: {
                    showImagePicker = true
                }, label: {
                    HStack {
                        Image(systemName: "person.2.crop.square.stack.fill")
                        Text("Album")
                    }
                })
                    .padding()
                
                Button(action: {
                    showImagePicker = true
                }, label: {
                    HStack {
                        Image(systemName: "camera.fill")
                        Text("Camera")
                    }
                })
                    .padding()
            }
            Image(uiImage: image)
                .resizable()
                .aspectRatio(contentMode: .fit)
            
            VStack(alignment: .leading) {
                Text("Filter")
                    .padding()
                ScrollView(.horizontal) {
                    HStack{
                        Button(action: {
                            image = pixelFilter(inputImage: image)
                        }, label: {
                            Text("Pixel")
                        })
                            .padding(.horizontal)
                        
                        Button(action: {
                            image = blurFilter(inputImage: image)
                        }, label: {
                            Text("Blur")
                        })
                            .padding(.horizontal)
                        Button(action: {
                            image = colorInvertFilter(inputImage: image)
                        }, label: {
                            Text("Invert")
                        })
                            .padding(.horizontal)
                        Button(action: {
                            image = colorPosterizeFilter(inputImage: image)
                        }, label: {
                            Text("Posterize")
                        })
                            .padding(.horizontal)
                        
                    }
                }
            }
            
            HStack {
                Button(action: {
                    image = imageBuffer
                }, label: {
                    HStack {
                        Image(systemName: "gobackward")
                        Text("Reset")
                    }
                })
                    .padding()
                
                Button(action: {
                    UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
                }, label: {
                    HStack {
                        Image(systemName: "square.and.arrow.down.fill")
                        Text("Save")
                    }
                })
                    .padding()
            }
            
        }
        .sheet(isPresented: $showImagePicker, content: {
            ImagePicker(sourceType: .photoLibrary) { image in
                self.image = image
            }
        })
        .sheet(isPresented: $showCameraPicker, content: {
            ImagePicker(sourceType: .camera) { image in
                self.image = image
            }
        })
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
