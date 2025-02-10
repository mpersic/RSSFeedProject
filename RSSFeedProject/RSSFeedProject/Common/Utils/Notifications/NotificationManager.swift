//
//  NotificationManager.swift
//  RSSFeedProject
//
//  Created by Matej Persic on 10.02.2025..
//

import SwiftUI
import UserNotifications

struct NotificationManager {
    
    static let categoryIdentifierKey = "RSS_CATEGORY"
    private static let notificationCenter = UNUserNotificationCenter.current()

    // Centralized setup method
    static func initialize() async {
        let isAuthorized = await requestAuthorization()
        if isAuthorized {
            print("Notification authorization granted")
            setupNotificationCategories()
        } else {
            print("Notification authorization denied")
        }
    }

    // Request user authorization for notifications
    static func requestAuthorization() async -> Bool {
        do {
            return try await notificationCenter.requestAuthorization(options: [.alert, .sound, .badge])
        } catch {
            print("Authorization failed: \(error.localizedDescription)")
            return false
        }
    }

    // Check if notifications are enabled
    static func isNotificationsEnabled() async -> Bool {
        let settings = await notificationCenter.notificationSettings()
        return settings.authorizationStatus == .authorized
    }

    // Define and register notification categories
    static func setupNotificationCategories() {
        let acceptAction = UNNotificationAction(
            identifier: "ACCEPT_ACTION",
            title: "Accept",
            options: [.foreground]
        )
        let declineAction = UNNotificationAction(
            identifier: "DECLINE_ACTION",
            title: "Decline",
            options: [.destructive]
        )
        let notificationCategory = UNNotificationCategory(
            identifier: categoryIdentifierKey,
            actions: [acceptAction, declineAction],
            intentIdentifiers: []
        )
        notificationCenter.setNotificationCategories([notificationCategory])
    }

    // Schedule a local notification
    static func scheduleLocalNotification(
        id: String,
        title: String,
        body: String,
        interval: TimeInterval
    ) async {
        let content = UNMutableNotificationContent()
        content.title = title
        content.body = body
        content.sound = .default
        content.categoryIdentifier = categoryIdentifierKey

        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: interval, repeats: false)
        let request = UNNotificationRequest(identifier: id, content: content, trigger: trigger)

        do {
            try await notificationCenter.add(request)
        } catch {
            print("Failed to schedule notification: \(error.localizedDescription)")
        }
    }
}
