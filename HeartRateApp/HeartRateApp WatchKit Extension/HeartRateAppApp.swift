//
//  HeartRateAppApp.swift
//  HeartRateApp WatchKit Extension
//
//  Created by Park Sungmin on 2022/08/23.
//

import SwiftUI

@main
struct HeartRateAppApp: App {
    @SceneBuilder var body: some Scene {
        WindowGroup {
            NavigationView {
                HeartRateView()
            }
        }

        WKNotificationScene(controller: NotificationController.self, category: "myCategory")
    }
}
