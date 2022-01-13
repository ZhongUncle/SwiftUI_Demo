//
//  PlayerModel.swift
//  AudioPlayer
//
//  Created by 钟宜江 on 2022/1/11.
//

import Foundation
import AVFoundation

struct AudioItems: Identifiable{
    var id: UUID = UUID()
    var name: String
    var author: String
    var format: String
}
var i: Int = 0
let playlist: [AudioItems] = [AudioItems(name: "马马嘟嘟骑", author: "一格", format: "m4a"), AudioItems(name: "Snow", author: "Red Hot Chilli Pepper", format: "m4a"), AudioItems(name: "Stay Gold", author: "一格Yige（cover.宇多田光）", format: "m4a")]

let player = AVPlayer()
//预先创建一个播放器
var audioPlayer: AVAudioPlayer?

class AudioGobalVaribles: ObservableObject {
    @Published var audioName: String = playlist[i].name
    @Published var audioFormat: String = playlist[i].format
    @Published var isPlaying: Bool = false
    @Published var showAudioList: Bool = false
    @Published var playValue: TimeInterval = 0.0
    var playerDuration: TimeInterval = 100
    var timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()

    func playAudio(forResource: String, ofType: String) {
        //定义路径
        let path = Bundle.main.path(forResource: forResource, ofType: ofType)!
        //定义url
        let url = URL(fileURLWithPath: path)
        do {
            if isPlaying == false && audioPlayer == nil {
                //尝试使用预设的声音播放器获取目标文件
                audioPlayer = try AVAudioPlayer(contentsOf: url)
                audioPlayer?.prepareToPlay()
                audioPlayer?.play()
                isPlaying = true
            }
            
            if isPlaying == false {
                //播放声音————停止的话使用stop()方法
                audioPlayer?.play()
                isPlaying = true
            }
            
            if isPlaying == true && audioPlayer != nil {
                //尝试使用预设的声音播放器获取目标文件
                audioPlayer = try AVAudioPlayer(contentsOf: url)
                audioPlayer?.prepareToPlay()
                audioPlayer?.play()
                isPlaying = true
            }
        } catch {
            //加载文件失败，这里用于防止应用程序崩溃
            print("音频文件出现问题")
        }
    }
    
    func pauseAudio() {
        if isPlaying == true {
            audioPlayer?.pause()
            isPlaying = false
        }
    }
    
    func stopAudio() {
        if isPlaying == true {
            audioPlayer?.stop()
            audioPlayer = nil
            isPlaying = false
            playValue = 0.0
        }
    }
    
    func playPrevious() {
        if i > 0{
            i -= 1
        }else{
            i = playlist.count-1
        }
        audioName = playlist[i].name
        audioFormat = playlist[i].format
        //定义路径
        let path = Bundle.main.path(forResource: audioName, ofType: audioFormat)!
        //定义url
        let url = URL(fileURLWithPath: path)
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: url)
            audioPlayer?.prepareToPlay()
            audioPlayer?.play()
            isPlaying = true
        } catch {
            //加载文件失败，这里用于防止应用程序崩溃
            print("音频文件出现问题")
        }
        
    }
    
    func playNext() {
        if i < playlist.count-1{
            i = i + 1
        }else{
            i = 0
        }
        audioName = playlist[i].name
        audioFormat = playlist[i].format
        //定义路径
        let path = Bundle.main.path(forResource: audioName, ofType: audioFormat)!
        //定义url
        let url = URL(fileURLWithPath: path)
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: url)
            audioPlayer?.prepareToPlay()
            audioPlayer?.play()
            isPlaying = true
        } catch {
            //加载文件失败，这里用于防止应用程序崩溃
            print("音频文件出现问题")
        }
    }
    
    func changeSliderValue() {
        if isPlaying == true {
            pauseAudio()
            audioPlayer?.currentTime = playValue
            
        }
        
        if isPlaying == false {
            audioPlayer?.play()
            isPlaying = true
        }
    }
}


