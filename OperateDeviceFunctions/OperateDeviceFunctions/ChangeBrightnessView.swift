//
//  ChangeBrightnessView.swift
//  OperateDeviceFunctions
//
//  Created by 钟宜江 on 2022/1/11.
//

import SwiftUI

struct ChangeBrightnessView: View {
    @State private var brightness = UIScreen.main.brightness
    
    var body: some View {
        VStack{
            Text("Change the brightness")
            /* use this method, the value will changed when the drag finished. */
//            Slider(value: $realTimeValues.brightness, onEditingChanged: { editing in
//                UIScreen.main.brightness = realTimeValues.brightness
//            })
            
            /* use onChange the brightness of screen will change real-time, instead of changed when the drag finished. */
            Slider(value: $brightness)
                .onChange(of: brightness) { newValue in
                    UIScreen.main.brightness = brightness
                }
        }
    }
}

struct ChangeBrightnessView_Previews: PreviewProvider {
    static var previews: some View {
        ChangeBrightnessView()
    }
}
