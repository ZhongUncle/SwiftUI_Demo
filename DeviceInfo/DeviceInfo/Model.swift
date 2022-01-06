//
//  Model.swift
//  DeviceInfo
//
//  Created by 钟宜江 on 2022/1/6.
//

import SwiftUI

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
