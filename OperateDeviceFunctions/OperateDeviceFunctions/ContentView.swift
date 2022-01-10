//
//  ContentView.swift
//  OperateDeviceFunctions
//
//  Created by 钟宜江 on 2022/1/10.
//

import SwiftUI

import MediaPlayer

class RealTimeValues: ObservableObject{
    @Published var brightness: CGFloat = UIScreen.main.brightness
    /* Need import MediaPlayer */
    @Published var volume: Float = AVAudioSession.sharedInstance().outputVolume
}

extension MPVolumeView {
    static func setVolume(_ volume: Float) {
        let volumeView = MPVolumeView()
        let slider = volumeView.subviews.first(where: { $0 is UISlider }) as? UISlider
    }
}

struct ContentView: View {
    @ObservedObject var realTimeValues = RealTimeValues()
    
    var body: some View {
        VStack(alignment: .leading) {
            //Change brightness of screen
            ChangeBrightnessView()
            VStack {
                Text("Change the volume")
                Slider(value: $realTimeValues.volume)
                    .onChange(of: realTimeValues.volume) { newValue in
                        MPVolumeView().subviews.first
                    }
            }
            //Open or close the torch
            TorchView()
            
            //Some kinds of haptices
            HapticView()
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
