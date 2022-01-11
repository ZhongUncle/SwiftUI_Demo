//
//  TorchView.swift
//  OperateDeviceFunctions
//
//  Created by 钟宜江 on 2022/1/11.
//

import SwiftUI
import AVFoundation

/* Need import AVFoundation */
func openTorch(on: Bool) {
    guard let device = AVCaptureDevice.default(for: .video) else { return }

    if device.hasTorch {
        do {
            try device.lockForConfiguration()

            if on == true {
                device.torchMode = .on
            } else {
                device.torchMode = .off
            }

            device.unlockForConfiguration()
        } catch {
            print("Torch could not be used")
        }
    } else {
        print("Torch is not available")
    }
}

struct TorchView: View {
    @State private var torched: Bool = false
    
    var body: some View {
        Button(action: {
            torched = !torched
            openTorch(on: torched)
            UINotificationFeedbackGenerator().notificationOccurred(.success)
        }) {
            ZStack {
                Circle()
                    .frame(width: 60, height: 60)
                    .foregroundColor(torched ? Color.white : Color.gray)
                Image(systemName: "flashlight.off.fill")
                    .imageScale(.large)
                    .foregroundColor(torched ? Color.gray : Color.white)
            }
        }
        .padding(.vertical)
    }
}

struct TorchView_Previews: PreviewProvider {
    static var previews: some View {
        TorchView()
    }
}
