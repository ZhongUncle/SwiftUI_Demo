//
//  PlayerView.swift
//  AudioPlayer
//
//  Created by 钟宜江 on 2022/1/11.
//

import SwiftUI
import AVKit
import Combine

struct PlayerView: View {
    @ObservedObject var audioGobalVaribles = AudioGobalVaribles()
    @State private var test = false
    
    var body: some View {
        HStack {
            Button(action: {
                audioGobalVaribles.i -= 1
                if audioGobalVaribles.i < 0{
                    audioGobalVaribles.i = playlist.count-1
                }
                
            }, label: {
                Image(systemName: "backward.fill")
                    .font(.title3)
            })

            Button(action: {
//                if audioGobalVaribles.isPlaying == true {
//                    audioGobalVaribles.pauseAudio()
//                }else{
//                    //The audio need add Target Membership to project
//                    audioGobalVaribles.playAudio(forResource: playlist[audioGobalVaribles.i], ofType: audioGobalVaribles.audioType)
//                    audioGobalVaribles.timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
//                }
                audioGobalVaribles.isPlaying = !audioGobalVaribles.isPlaying
            }, label: {
                Image(systemName: (audioGobalVaribles.isPlaying) ? "pause.fill" : "play.fill")
                    .font(.title)
            })
                .padding()
            
            Button(action: {
                audioGobalVaribles.playNext()
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
