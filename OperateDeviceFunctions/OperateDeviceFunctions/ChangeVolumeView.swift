//
//  ChangeVolumeView.swift
//  OperateDeviceFunctions
//
//  Created by 钟宜江 on 2022/1/11.
//

import SwiftUI
import MediaPlayer

struct ChangeVolumeView: View {
    @State private var volume = AVAudioSession.sharedInstance().outputVolume
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Volume")
                .fontWeight(.bold)
            HStack {
                Image(systemName: "minus")
                    .foregroundColor(Color.pink)
                Slider(value: $volume)
                    .onChange(of: volume) { newValue in
                        MPVolumeView.setVolume(volume)
                    }
                Image(systemName: "plus")
                    .foregroundColor(Color.pink)
            }
            .accentColor(Color.pink)
        }
    }
}

extension MPVolumeView {
    static func setVolume(_ volume: Float) {
        let volumeView = MPVolumeView(frame: .zero)
        let slider = volumeView.subviews.first(where: { $0 is UISlider }) as? UISlider
        //Need this to change volume consistently
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.01) {
            slider?.value = volume
        }
    }
}

struct ChangeVolumeView_Previews: PreviewProvider {
    static var previews: some View {
        ChangeVolumeView()
    }
}
