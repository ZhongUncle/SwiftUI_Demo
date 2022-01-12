//
//  PlayerView.swift
//  AudioPlayer
//
//  Created by 钟宜江 on 2022/1/11.
//

import SwiftUI
import AVKit
import Combine

let playlist: [String] = ["马马嘟嘟骑", "Snow-Red Hot Chilli Pepper"]

let player = AVPlayer()

struct PlayButtonView: View {
    var audioName: String
    var audioType: String
    @ObservedObject var audioGobalVaribles = AudioGobalVaribles()
    
    var body: some View {
        Button(action: {
            if audioGobalVaribles.isPlaying {
                audioGobalVaribles.pauseAudio()
                audioGobalVaribles.isPlaying = !audioGobalVaribles.isPlaying
            }else{
                //The audio need add Target Membership to project
                audioGobalVaribles.playAudio(forResource: audioName, ofType: audioType)
                self.audioGobalVaribles.timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
                audioGobalVaribles.isPlaying = !audioGobalVaribles.isPlaying
            }
        }, label: {
            Image(systemName: (audioGobalVaribles.isPlaying) ? "pause.fill" : "play.fill")
                .font(.title)
        })
            .padding()
    }
}

struct PlayerView: View {
    @ObservedObject var audioGobalVaribles = AudioGobalVaribles()
    
    @State private var i = 0
    
    var body: some View {
        HStack {
            Button(action: {
                i -= 1
                if i < 0{
                    i = playlist.count-1
                }
                audioGobalVaribles.playAudio(forResource: playlist[i], ofType: "m4a")
                
            }, label: {
                Image(systemName: "backward.fill")
                    .font(.title3)
            })

            PlayButtonView(audioName: playlist[i], audioType: "m4a")
            
            Button(action: {
                i += 1
                if i > playlist.count-1{
                    i = 0
                }
                audioGobalVaribles.playAudio(forResource: playlist[i], ofType: "m4a")
            }, label: {
                Image(systemName: "forward.fill")
                    .font(.title3)
            })
        }
        .foregroundColor(Color.pink)
    }
}

struct PlayerView_Previews: PreviewProvider {
    static var previews: some View {
        PlayerView()
    }
}
