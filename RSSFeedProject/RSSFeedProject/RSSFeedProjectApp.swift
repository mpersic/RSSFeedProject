//
//  RSSFeedProjectApp.swift
//  RSSFeedProject
//
//  Created by Matej Persic on 08.02.2025..
//

import SwiftUI

@main
struct RSSFeedProjectApp: App {

    private let notificationDelegate = NotificationDelegate()

    init() {
        UNUserNotificationCenter.current().delegate = notificationDelegate
        Task {
            await NotificationManager.initialize()
        }
    }

    var body: some Scene {
        WindowGroup {
            SplashView()
        }
    }
}
