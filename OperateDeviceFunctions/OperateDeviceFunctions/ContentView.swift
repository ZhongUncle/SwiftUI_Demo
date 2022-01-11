//
//  ContentView.swift
//  OperateDeviceFunctions
//
//  Created by 钟宜江 on 2022/1/10.
//

import SwiftUI

struct ContentView: View {
    
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Change")
                .font(.title)
                .fontWeight(.bold)
                .padding([.top, .bottom, .trailing])
            //Change brightness of screen
            ChangeBrightnessView()
            
            //Change volume of output
            ChangeVolumeView()
            
            Text("Torch")
                .font(.title)
                .fontWeight(.bold)
                .padding([.top, .bottom, .trailing])
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
