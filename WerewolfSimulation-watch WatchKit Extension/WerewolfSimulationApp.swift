//
//  WerewolfSimulationApp.swift
//  WerewolfSimulation-watch WatchKit Extension
//
//  Created by 叶絮雷 on 2020/11/21.
//

import SwiftUI

@main
struct WerewolfSimulationApp: App {
    @SceneBuilder var body: some Scene {
        WindowGroup {
            NavigationView {
                ContentView()
            }
        }

        WKNotificationScene(controller: NotificationController.self, category: "myCategory")
    }
}
