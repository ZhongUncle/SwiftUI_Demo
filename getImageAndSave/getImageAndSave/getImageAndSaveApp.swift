//
//  getImageAndSaveApp.swift
//  getImageAndSave
//
//  Created by 钟宜江 on 2021/9/4.
//

import SwiftUI

@main
struct getImageAndSaveApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
//            ContentView()
//                .environment(\.managedObjectContext, persistenceController.container.viewContext)
            GetImageView()
        }
    }
}
