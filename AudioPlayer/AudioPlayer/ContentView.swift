//
//  ContentView.swift
//  AudioPlayer
//
//  Created by 钟宜江 on 2022/1/11.
//

import SwiftUI

let screenWidth = UIScreen.main.bounds.width
let screenHeight = UIScreen.main.bounds.height

struct ContentView: View {
    @ObservedObject var audioGobalVaribles = AudioGobalVaribles()
    @State private var sliderTimeline = 0.0
    var body: some View {
        ZStack {
            Rectangle()
                .foregroundColor(Color(red: 0.1, green: 0.1, blue: 0.1))
                .ignoresSafeArea()
            VStack {
                Spacer()
                
                MusicCoverView()
                Text("\(audioGobalVaribles.audioName)")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(Color.white)
                Text("\(audioGobalVaribles.audioCreater)")
                    .foregroundColor(.gray)
                    .padding(.top, -5.0)
                    
                Spacer()
                
                HStack {
                    Text("\(String(sliderTimeline))")
                        .foregroundColor(Color.gray)
                        .padding(.leading)
                    Slider(value: $audioGobalVaribles.playValue, in: TimeInterval(0.0)...audioGobalVaribles.playerDuration, onEditingChanged: { _ in
                        audioGobalVaribles.changeSliderValue()
                    })
                        .accentColor(Color.gray)
                        .onReceive(audioGobalVaribles.timer) { _ in
                            
                            if audioGobalVaribles.isPlaying {
                                if let currentTime = audioGobalVaribles.audioPlayer?.currentTime {
                                    audioGobalVaribles.playValue = currentTime
                                    
                                    if currentTime == TimeInterval(0.0) {
                                        audioGobalVaribles.isPlaying = false
                                    }
                                }
                                
                            }
                            else {
                                audioGobalVaribles.isPlaying = false
                                audioGobalVaribles.timer.upstream.connect().cancel()
                            }
                        }
                    Text("0:00")
                        .foregroundColor(Color.gray)
                        .padding(.trailing)
                }

                Spacer()
                
                ZStack {
                    PlayerView()
                        .background(
                            RoundedRectangle(cornerRadius: 10)
                                .frame(width: screenWidth, height: screenHeight*0.07)
                                .foregroundColor(Color(red: 0.3, green: 0.3, blue: 0.3))
                        )
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
