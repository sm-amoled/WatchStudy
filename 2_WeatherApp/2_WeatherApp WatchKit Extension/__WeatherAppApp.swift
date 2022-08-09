//
//  __WeatherAppApp.swift
//  2_WeatherApp WatchKit Extension
//
//  Created by Park Sungmin on 2022/08/07.
//

import SwiftUI

@main
struct __WeatherAppApp: App {
    @SceneBuilder var body: some Scene {
        WindowGroup {
            NavigationView {
                WatchWeatherView()
            }
        }

        WKNotificationScene(controller: NotificationController.self, category: "myCategory")
    }
}
