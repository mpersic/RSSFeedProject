//
//  RSSFeedProjectApp.swift
//  RSSFeedProject
//
//  Created by Matej Persic on 08.02.2025..
//

import BackgroundTasks
import Factory
import SwiftUI

@main
struct RSSFeedProjectApp: App {

    @Environment(\.scenePhase) private var phase
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
        .onChange(of: phase) {
            switch phase {
            case .background: scheduleAppRefresh()
            default: break
            }
        }
        .backgroundTask(.appRefresh("com.mperr.refresh")) {
            await handleNewNotification()
        }
    }

    private func scheduleAppRefresh() {
        let request = BGAppRefreshTaskRequest(identifier: "com.mperr.refresh")
        request.earliestBeginDate = .now.addingTimeInterval(15 * 60)
        try? BGTaskScheduler.shared.submit(request)
    }

    private func handleNewNotification() async {
        let isEnabled =
            await NotificationManager.isNotificationsEnabled()
        if !isEnabled {
            return
        }
        @Injected(\.feedService) var feedService
        let items = await feedService.getDifferentItems()
        for item in items {

            await NotificationManager.scheduleLocalNotification(
                id: UUID().uuidString,
                title: item.title ?? "Updated Feed Item",
                body:
                    item.description ?? "No description available",
                interval: 1
            )
        }
    }
}
