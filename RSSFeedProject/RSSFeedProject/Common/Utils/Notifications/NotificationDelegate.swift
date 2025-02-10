//
//  NotificationDelegate.swift
//  RSSFeedProject
//
//  Created by Matej Persic on 10.02.2025..
//

import UserNotifications

class NotificationDelegate: NSObject, UNUserNotificationCenterDelegate {
    // Handle user actions
    func userNotificationCenter(
        _ center: UNUserNotificationCenter,
        didReceive response: UNNotificationResponse,
        withCompletionHandler completionHandler: @escaping () -> Void
    ) {
        if response.notification.request.content.categoryIdentifier == NotificationManager.categoryIdentifierKey {
            switch response.actionIdentifier {
            case "ACCEPT_ACTION":
                print("User accepted the notification")
            case "DECLINE_ACTION":
                print("User declined the notification")
            default:
                print("Unhandled action: \(response.actionIdentifier)")
            }
        }
        completionHandler()
    }

    // Handle foreground notifications
    func userNotificationCenter(
        _ center: UNUserNotificationCenter,
        willPresent notification: UNNotification,
        withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void
    ) {
        print("Notification received while app is open")
        completionHandler([.banner, .sound]) // Show actionable notifications in the foreground
    }
}
