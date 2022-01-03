//
//  filterView.swift
//  CameraDemo
//
//  Created by 钟宜江 on 2021/12/8.
//

import SwiftUI

//pixel a image
func pixelFilter(inputImage: UIImage) -> UIImage {
    //Create a CIContext() to place the processed content(it's the image)
    let context = CIContext()
    //Convert the UIImage inputed to CIImage
    let inputCIImage = CIImage(image: inputImage)!
    
    //Create the filter which image will be changed in
    //You can look up more details about filters in the document: https://developer.apple.com/library/archive/documentation/GraphicsImaging/Reference/CoreImageFilterReference/index.html#//apple_ref/doc/filter/
    let filter = CIFilter(name: "CIPixellate")!
    //Sometimes when setting the setValue, the name of argument will be need changed, add kCI- as prefix and add -Key as suffix to the name in document
    //Set the level of pixel
    filter.setValue(30, forKey: kCIInputScaleKey)
    //Set image inputed
    filter.setValue(inputCIImage, forKey: kCIInputImageKey)

    //Get image processed by filter, and take it into the CIContext() created in the beginning
    let result = filter.outputImage!
    let cgImage = context.createCGImage(result, from: result.extent)
    
    //return processed image
    return UIImage(cgImage: cgImage!)
}

//Blur a image
func blurFilter(inputImage: UIImage) -> UIImage {

    let context = CIContext()
    let inputCIImage = CIImage(image: inputImage)!

    let filter = CIFilter(name: "CIBoxBlur")!
    filter.setValue(inputCIImage, forKey: kCIInputImageKey)

    let result = filter.outputImage!
    let cgImage = context.createCGImage(result, from: result.extent)
    
    return UIImage(cgImage: cgImage!)
}

//Inverts the colors in an image.
func colorInvertFilter(inputImage: UIImage) -> UIImage {
    let context = CIContext()
    let inputCIImage = CIImage(image: inputImage)!
    
    let filter = CIFilter(name: "CIColorInvert")!
    filter.setValue(inputCIImage, forKey: kCIInputImageKey)

    let result = filter.outputImage!
    let cgImage = context.createCGImage(result, from: result.extent)
    
    return UIImage(cgImage: cgImage!)
}

//Remaps red, green, and blue color components to the number of brightness values you specify for each color component.
func colorPosterizeFilter(inputImage: UIImage) -> UIImage {
    let context = CIContext()
    let inputCIImage = CIImage(image: inputImage)!
    
    let filter = CIFilter(name: "CIColorPosterize")!
    filter.setValue(inputCIImage, forKey: kCIInputImageKey)

    let result = filter.outputImage!
    let cgImage = context.createCGImage(result, from: result.extent)
    
    return UIImage(cgImage: cgImage!)
}
