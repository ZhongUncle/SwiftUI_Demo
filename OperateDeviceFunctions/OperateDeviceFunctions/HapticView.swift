//
//  HapticView.swift
//  OperateDeviceFunctions
//
//  Created by 钟宜江 on 2022/1/11.
//

import SwiftUI

struct HapticView: View {
    let haptic = UINotificationFeedbackGenerator()
    var body: some View {
        VStack(alignment: .leading) {
            Text("Haptic")
                .font(.title)
                .fontWeight(.bold)
                .padding([.top, .bottom, .trailing])
            // Some kind of haptices
            HStack {
                Spacer()
                Button(action: {
                    haptic.notificationOccurred(.error)
                }) {
                    ZStack {
                        RoundedRectangle(cornerRadius: 15)
                            .frame(width: 100, height: 60)
                            .foregroundColor(Color.pink)
                        Text("Error")
                            .fontWeight(.bold)
                            .foregroundColor(Color.yellow)
                    }
                }
                Spacer()
                Button(action: {
                    haptic.notificationOccurred(.success)
                }) {
                    ZStack {
                        RoundedRectangle(cornerRadius: 15)
                            .frame(width: 100, height: 60)
                            .foregroundColor(Color.pink)
                        Text("Success")
                            .fontWeight(.bold)
                            .foregroundColor(Color.yellow)
                    }
                }
                Spacer()
                Button(action: {
                    haptic.notificationOccurred(.warning)
                }) {
                    ZStack {
                        RoundedRectangle(cornerRadius: 15)
                            .frame(width: 100, height: 60)
                            .foregroundColor(Color.pink)
                        Text("Warning")
                            .fontWeight(.bold)
                            .foregroundColor(Color.yellow)
                    }
                }
                Spacer()
            }
            
            HStack{
                Spacer()
                Button(action: {
                    UIImpactFeedbackGenerator(style: .light).impactOccurred()
                }) {
                    ZStack {
                        RoundedRectangle(cornerRadius: 15)
                            .frame(width: 100, height: 60)
                            .foregroundColor(Color.pink)
                        Text("Light")
                            .fontWeight(.bold)
                            .foregroundColor(Color.yellow)
                    }
                }
                Spacer()
                Button(action: {
                    UIImpactFeedbackGenerator(style: .medium).impactOccurred()
                }) {
                    ZStack {
                        RoundedRectangle(cornerRadius: 15)
                            .frame(width: 100, height: 60)
                            .foregroundColor(Color.pink)
                        Text("Medium")
                            .fontWeight(.bold)
                            .foregroundColor(Color.yellow)
                    }
                    
                }
                Spacer()
                Button(action: {
                    UIImpactFeedbackGenerator(style: .heavy).impactOccurred()
                }) {
                    ZStack {
                        RoundedRectangle(cornerRadius: 15)
                            .frame(width: 100, height: 60)
                            .foregroundColor(Color.pink)
                        Text("Heavy")
                            .fontWeight(.bold)
                            .foregroundColor(Color.yellow)
                            
                    }
                }
                Spacer()
                
            }
        }
    }
}

struct HapticView_Previews: PreviewProvider {
    static var previews: some View {
        HapticView()
    }
}
