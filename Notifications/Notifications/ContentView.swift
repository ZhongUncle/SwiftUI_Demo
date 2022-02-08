//
//  ContentView.swift
//  Notifications
//
//  Created by 钟宜江 on 2022/2/7.
//

import SwiftUI
import UserNotifications

func setNotification(){
    UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]){ (granted, _) in
        if granted {
            //用户同意我们推送通知
            print("用户同意我们推送通知")
        }else{
            //用户不同意
            print("用户不同意")
        }
    }
}

//基础推送通知
func makeBasicNotification(){
    //设置通知的时间：5秒钟后推送通知
    let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
    
    //通知的内容
    let content = UNMutableNotificationContent()
    content.title = "通知的标题"
    content.body = "通知的内容"
    /* 需要注意这个自定义的提示音不能超过30秒，不然系统会播放默认声音 */
    content.sound = UNNotificationSound.init(named: UNNotificationSoundName("ring.m4a"))
    
    //完成通知的设置
    let request = UNNotificationRequest(identifier: "通知名称", content: content, trigger: trigger)
    //添加我们的通知到UNUserNotificationCenter推送的队列里
    UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
}

//推送通知
func makeAlarmNotification(){
    //设置通知的时间：推送时间为6点30分
    var dateComponents = DateComponents()
    dateComponents.hour = 6
    dateComponents.minute = 30
    //这里最后让repeats为true表示每天的6点30分都会推送通知
    let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
    
    //通知的内容
    let content = UNMutableNotificationContent()
    content.title = "通知的标题"
    content.body = "通知的内容"
    /* 需要注意这个自定义的提示音不能超过30秒，不然系统会播放默认声音 */
    content.sound = UNNotificationSound.init(named: UNNotificationSoundName("ring.m4a"))
    
    //完成通知的设置
    let request = UNNotificationRequest(identifier: "通知名称", content: content, trigger: trigger)
    //添加我们的通知到UNUserNotificationCenter推送的队列里
    UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
}

struct ContentView: View {
    var body: some View {
        VStack {
            Button(action: {
                setNotification()
            }) {
                Text("获取推送权限")
                    .padding()
            }
            Button(action: {
                makeAlarmNotification()
            }) {
                Text("推送基础款通知")
                    .padding()
            }
            Button(action: {
                makeAlarmNotification()
            }) {
                Text("推送定时闹钟型通知")
                    .padding()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
