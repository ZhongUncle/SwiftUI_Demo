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
    @State private var showAudioList = false
    
    //make background of List is clear and separator is black——让List的外围背景是透明的，并且分割线是黑色
    init() {
            UITableView.appearance().backgroundColor = .clear
            UITableView.appearance().separatorColor = .black
        }
    
    var body: some View {
        ZStack {
            //Background——背景
            Rectangle()
                .foregroundColor(Color(red: 0.1, green: 0.1, blue: 0.1))
                .ignoresSafeArea()
            VStack {
                Spacer()
                //Music Cover——封面
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
                            //如果正在播放——if playing
                            if audioGobalVaribles.isPlaying {
                                //如果当前时间不为空值——if currentTime isn't nil
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
                //List of audioes——音频列表
                if showAudioList {
                    List {
                        ForEach(0 ..< playlist.count) { n in
                            Button(action: {
                                i = n
                                audioGobalVaribles.playAudio(forResource: playlist[i].name, ofType: playlist[i].format)
                                //激活计时器——active timer
                                audioGobalVaribles.timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
                            }, label: {
                                HStack{
                                    Text("\(playlist[n].name) - ")
                                        .fontWeight(.bold)
                                        .foregroundColor(Color.white)
                                    Text("\(playlist[n].author)")
                                        .fontWeight(.medium)
                                        .foregroundColor(Color.white)
                                }
                            })
                                .listRowBackground(Color(red: 0.2, green: 0.15, blue: 0.15))
                        }
                    }
                }

                ZStack {
                    HStack(alignment: .center) {
                        Spacer()
                        //Play previous audio Button——上一首按钮
                        Button(action: {
                            audioGobalVaribles.playPrevious()
                        }, label: {
                            Image(systemName: "backward.fill")
                                .font(.title3)
                        })

                        //Play Button——播放按钮
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
                        
                        //Play next audio Button——下一首按钮
                        Button(action: {
                            audioGobalVaribles.playNext()
                        }, label: {
                            Image(systemName: "forward.fill")
                                .font(.title3)
                        })
                        Spacer()
                    }
                    .background(
                        RoundedRectangle(cornerRadius: 10)
                            .frame(width: screenWidth, height: screenHeight*0.07)
                            .foregroundColor(Color(red: 0.3, green: 0.3, blue: 0.3))
                    )
                    HStack {
                        Spacer()
                        Button(action: {
                            showAudioList = !showAudioList
                        }, label: {
                            Image(systemName: "list.bullet")
                                .font(.title)
                        })
                            .padding()
                    }
                }
                .foregroundColor(Color.pink)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
