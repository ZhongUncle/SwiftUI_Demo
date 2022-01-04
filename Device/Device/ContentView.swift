//
//  ContentView.swift
//  Device
//
//  Created by 钟宜江 on 2021/4/2.
//

import SwiftUI
import Foundation

class BatteryStatusModel: ObservableObject {
    //设定初始状态
    @Published var status: UIDevice.BatteryState = .unknown
    //定义显示剩余电量的变量remain
    @Published var level = ""
    
    //设定变量
    @objc func batteryLevelChanged(notification: Notification) {
        level = String(format: "%f", UIDevice.current.batteryLevel * 100)
    }
    
    @objc func batteryStateChanged(notification: Notification) {
        status = UIDevice.current.batteryState
    }
    
    //电池状态监视开始
    func startMonitor() {
        //电池电量变化时的通知
        NotificationCenter.default.addObserver(self, selector: #selector(batteryLevelChanged(notification:)), name: UIDevice.batteryLevelDidChangeNotification, object: nil)
        //电池状态变化时的通知
        NotificationCenter.default.addObserver(self, selector: #selector(batteryStateChanged(notification:)), name: UIDevice.batteryStateDidChangeNotification, object: nil)
        //开启电池监视
        UIDevice.current.isBatteryMonitoringEnabled = true
        //电池发生变化之后，必须要更新设定的初始值
        level = String(format: "%0.1f", UIDevice.current.batteryLevel * 100)
        status = UIDevice.current.batteryState
    }
    
    //终止电池监视
    func stopMonitor() {
        //关闭电池监视
        UIDevice.current.isBatteryMonitoringEnabled = false
        //关闭通知的监控者
        NotificationCenter.default.removeObserver(self, name: UIDevice.batteryLevelDidChangeNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIDevice.batteryStateDidChangeNotification, object: nil)
    }
}





//获得设备硬件信息

//let name = UIDevice.current.name

//func battery() -> Int {
//    UIDevice.current.isBatteryMonitoringEnabled = true
//    let aaa = Int(UIDevice.current.batteryLevel * 100)
//
//    return aaa
//}

//let battery = { () -> Int in
//    UIDevice.current.isBatteryMonitoringEnabled = true
//    let aaa = Int(UIDevice.current.batteryLevel * 100)
//
//    return aaa
//}

//var batteryLevel: Int {
//    UIDevice.current.isBatteryMonitoringEnabled = true
//    let data = Int(UIDevice.current.batteryLevel * 100)
//
//    return data
//}


//获得电池状态
    
//    func batteryState() -> String {
//        UIDevice.current.isBatteryMonitoringEnabled = true
//        let state = UIDevice.current.batteryState
//
//
//        switch state {
//
//        case .unplugged:
//            return "没在充电哦"
//        case .charging:
//            return "充电中"
//        case .full:
//            return "满啦"
//        case .unknown:
//            return "我咋知道"
//        @unknown default:
//            return "我咋知道"
//        }
//    }
    
//    let batteryState = { () -> String in
//        UIDevice.current.isBatteryMonitoringEnabled = true
//        var state = UIDevice.current.batteryState
//
//
//        switch state {
//
//        case .unplugged:
//            return "没在充电哦"
//        case .charging:
//            return "充电中"
//        case .full:
//            return "满啦"
//        case .unknown:
//            return "我咋知道"
//        @unknown default:
//            return "我咋知道"
//        }
//    }

struct ContentView: View {
    @ObservedObject var batteryInfo = BatteryStatusModel()

    var body: some View {
        VStack {
            Text("Battery level is\(batteryInfo.level)%")

            if batteryInfo.status == .charging {
                Text("Charging")
            } else if batteryInfo.status == .full {
                Text("Full battery")
            } else if batteryInfo.status == .unplugged {
                Text("Battery Unplugged")
            } else if batteryInfo.status == .unknown {
                Text("Unknown")
            }
        }
        .onAppear() {
            //Start the monitor of status of device
            self.batteryInfo.startMonitor()
        }
        .onDisappear() {
            //Stop the monitor of status of device
            self.batteryInfo.stopMonitor()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
