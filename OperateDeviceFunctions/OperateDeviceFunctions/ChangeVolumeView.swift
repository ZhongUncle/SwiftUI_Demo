//
//  ChangeVolumeView.swift
//  OperateDeviceFunctions
//
//  Created by 钟宜江 on 2022/1/11.
//

import SwiftUI

struct ChangeVolumeView: View {
    @ObservedObject var realTimeValues = RealTimeValues()
    
    var body: some View {
        VStack {
            Text("Change the volume")
            Slider(value: $realTimeValues.volume)
                .onChange(of: realTimeValues.volume) { newValue in
                    
                }
        }
    }
}

struct ChangeVolumeView_Previews: PreviewProvider {
    static var previews: some View {
        ChangeVolumeView()
    }
}
