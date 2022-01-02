//
//  filterView.swift
//  CameraDemo
//
//  Created by 钟宜江 on 2021/12/8.
//

import SwiftUI

func pixelFilter(inputImage: UIImage) -> UIImage {
    //创建一个CIContext()，用来放置处理后的内容
    let context = CIContext()
    //将输入的UIImage转变成CIImage
    let inputCIImage = CIImage(image: inputImage)!
    
    //创建用于处理图片的滤镜（Filter）https://developer.apple.com/library/archive/documentation/GraphicsImaging/Reference/CoreImageFilterReference/index.html#//apple_ref/doc/filter/ci/CIDiscBlur
    let filter = CIFilter(name: "CIPixellate")!
    //这个setValue设置值的时候，后面的forKey参数跟的是文档给的参数的名字的变形，比如这里官网给的是inputRadius，加上kCI-和-Key就是应该填的参数了。
    //这里设置模糊度
//    filter.setValue(10, forKey: kCIInputRadiusKey)
    filter.setValue(30, forKey: kCIInputScaleKey)
    //设置输入图片
    filter.setValue(inputCIImage, forKey: kCIInputImageKey)

    // 获取经过滤镜处理之后的图片，并且将其放置在开头设置好的CIContext()中
    let result = filter.outputImage!
    let cgImage = context.createCGImage(result, from: result.extent)
    
    //返回处理好的图片
    return UIImage(cgImage: cgImage!)
}

func blurFilter(inputImage: UIImage) -> UIImage {
    //创建一个CIContext()，用来放置处理后的内容
    let context = CIContext()
    //将输入的UIImage转变成CIImage
    let inputCIImage = CIImage(image: inputImage)!
    
    //创建用于处理图片的滤镜（Filter）https://developer.apple.com/library/archive/documentation/GraphicsImaging/Reference/CoreImageFilterReference/index.html#//apple_ref/doc/filter/ci/CIDiscBlur
    let filter = CIFilter(name: "CIBoxBlur")!
    //这个setValue设置值的时候，后面的forKey参数跟的是文档给的参数的名字的变形，比如这里官网给的是inputRadius，加上kCI-和-Key就是应该填的参数了。
    //这里设置模糊度
//    filter.setValue(10, forKey: kCIInputRadiusKey)
//    filter.setValue(100, forKey: kCIInputScaleKey)
    //设置输入图片
    filter.setValue(inputCIImage, forKey: kCIInputImageKey)

    // 获取经过滤镜处理之后的图片，并且将其放置在开头设置好的CIContext()中
    let result = filter.outputImage!
    let cgImage = context.createCGImage(result, from: result.extent)
    
    //返回处理好的图片
    return UIImage(cgImage: cgImage!)
}
