//
//  ContentView.swift
//  Device
//
//  Created by 钟宜江 on 2021/4/2.
//

import SwiftUI

func getIPAddresses() -> [String] {
    var addresses = [String]()

    // Get list of all interfaces on the local machine:
    var ifaddr : UnsafeMutablePointer<ifaddrs>?
    guard getifaddrs(&ifaddr) == 0 else { return [] }
    guard let firstAddr = ifaddr else { return [] }

    // For each interface ...
    for ptr in sequence(first: firstAddr, next: { $0.pointee.ifa_next }) {
        let flags = Int32(ptr.pointee.ifa_flags)
        let addr = ptr.pointee.ifa_addr.pointee

        // Check for running IPv4, IPv6 interfaces. Skip the loopback interface.
        if (flags & (IFF_UP|IFF_RUNNING|IFF_LOOPBACK)) == (IFF_UP|IFF_RUNNING) {
            if addr.sa_family == UInt8(AF_INET) || addr.sa_family == UInt8(AF_INET6) {

                // Convert interface address to a human readable string:
                var hostname = [CChar](repeating: 0, count: Int(NI_MAXHOST))
                if (getnameinfo(ptr.pointee.ifa_addr, socklen_t(addr.sa_len), &hostname, socklen_t(hostname.count),
                                nil, socklen_t(0), NI_NUMERICHOST) == 0) {
                    let address = String(cString: hostname)
                    addresses.append(address)
                }
            }
        }
    }

    freeifaddrs(ifaddr)
    return addresses
}


//obtain informations about device and system
let deviceName = UIDevice.current.name
let deviceModel = UIDevice.current.model
let systemName = UIDevice.current.systemName
let systemVersion = UIDevice.current.systemVersion

//obtain informations about screen
let screenPointWidth = UIScreen.main.bounds.width
let screenPointHeight = UIScreen.main.bounds.height
let screenPixelWidth = UIScreen.main.nativeBounds.width
let screenPixelHeight = UIScreen.main.nativeBounds.height
let screenBrightness = UIScreen.main.brightness

let ipAddress = getIPAddresses()
let macAddress = UIDevice.current.identifierForVendor!.uuidString


struct ContentView: View {
    @ObservedObject var batteryInfo = BatteryStatusModel()

    var body: some View {
        List {
            //Some device Info
            HStack {
                Text("Device")
                Spacer()
                Text("\(deviceName)")
            }
            HStack {
                Text("Model")
                Spacer()
                Text("\(deviceModel)")
            }
            HStack {
                Text("System")
                Spacer()
                Text("\(systemName) \(systemVersion)")
            }
            
            //Information about level and status of battery
            HStack {
                Text("Battery level")
                Spacer()
                Text("\(batteryInfo.level)%")
            }
            
            HStack{
                Text("Battery status")
                Spacer()
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
            
            //Some screen Info
            HStack {
                Text("Screen in points(w*h)")
                Spacer()
                Text("\(Int(screenPointWidth)) * \(Int(screenPointHeight))")
            }
            HStack {
                Text("Screen in pixels(w*h)")
                Spacer()
                Text("\(Int(screenPixelWidth)) * \(Int(screenPixelHeight))")
            }
            HStack {
                Text("Screen bringhting")
                Spacer()
                Text("\(Int(screenBrightness))")
            }
            HStack {
                Text("IP")
                Spacer()
                Text("\(ipAddress[2])" as String)
            }
            HStack {
                Text("Mac")
                Spacer()
                Text(macAddress)
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
