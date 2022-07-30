//
//  __WatchTaskAppApp.swift
//  1_WatchTaskApp WatchKit Extension
//
//  Created by Park Sungmin on 2022/07/31.
//

import SwiftUI

@main
struct __WatchTaskAppApp: App {
    @SceneBuilder var body: some Scene {
        WindowGroup {
            NavigationView {
                ContentView()
            }
        }

        WKNotificationScene(controller: NotificationController.self, category: "myCategory")
    }
}
