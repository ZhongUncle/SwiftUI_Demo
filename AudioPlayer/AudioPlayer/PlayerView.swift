//
//  PlayerView.swift
//  AudioPlayer
//
//  Created by 钟宜江 on 2022/1/11.
//

import SwiftUI
import AVKit
import Combine

struct PlayButtonView: View {
//    var audioName: String
//    var audioType: String
    @ObservedObject var audioGobalVaribles = AudioGobalVaribles()
    
    var body: some View {
        Button(action: {
            if audioGobalVaribles.isPlaying {
                audioGobalVaribles.pauseAudio()
            }else{
                //The audio need add Target Membership to project
                audioGobalVaribles.playAudio(forResource: playlist[audioGobalVaribles.i], ofType: audioGobalVaribles.audioType)
                self.audioGobalVaribles.timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
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
    
    var body: some View {
        HStack {
            Button(action: {
                audioGobalVaribles.i -= 1
                if audioGobalVaribles.i < 0{
                    audioGobalVaribles.i = playlist.count-1
                }
                audioGobalVaribles.playAudio(forResource: playlist[audioGobalVaribles.i], ofType: audioGobalVaribles.audioType)
            }, label: {
                Image(systemName: "backward.fill")
                    .font(.title3)
            })

//            PlayButtonView(audioName: playlist[audioGobalVaribles.i], audioType: audioGobalVaribles.audioType)
            PlayButtonView()
            
            Button(action: {
                audioGobalVaribles.i += 1
                if audioGobalVaribles.i > playlist.count-1{
                    audioGobalVaribles.i = 0
                }
                audioGobalVaribles.playAudio(forResource: playlist[audioGobalVaribles.i], ofType: audioGobalVaribles.audioType)
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
