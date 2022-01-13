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
            //Background
            Rectangle()
                .foregroundColor(Color(red: 0.1, green: 0.1, blue: 0.1))
                .ignoresSafeArea()
            VStack {
                Spacer()
                //Music Cover
                MusicCoverView()
                Text("\(playlist[i].name)")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(Color.white)
                Text("\(playlist[i].author)")
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
                                if let currentTime = audioPlayer?.currentTime {
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
                    HStack {
                        Text(playlist[i].name)
                        //Play previous audio Button
                        Button(action: {
                            audioGobalVaribles.playPrevious()
                        }, label: {
                            Image(systemName: "backward.fill")
                                .font(.title3)
                        })

                        //Play Button
                        Button(action: {
                            if audioGobalVaribles.isPlaying == true {
                                audioGobalVaribles.pauseAudio()
                            }else{
                                /* The audio need add Target Membership to project */
                                audioGobalVaribles.playAudio(forResource: playlist[i].name, ofType: playlist[i].format)
                                audioGobalVaribles.timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
                            }
                        }, label: {
                            Image(systemName: (audioGobalVaribles.isPlaying) ? "pause.fill" : "play.fill")
                                .font(.title)
                        })
                            .padding()
                        
                        //Play next audio Button
                        Button(action: {
                            audioGobalVaribles.playNext()
                        }, label: {
                            Image(systemName: "forward.fill")
                                .font(.title3)
                        })
                    }
                    .foregroundColor(Color.pink)
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
