//
//  SettingsPage.swift
//  RSSFeedProject
//
//  Created by Matej Persic on 08.02.2025..
//

import Factory
import SwiftUI

struct SettingsPage: View {

    @InjectedObject(\.settingsVM) private var vm

    var body: some View {
        List {
            clearFeed()

            chooseAppearance()

            chooseLanguage()

            toggleNotifications()
        }
        .uses(vm.alertManager)
    }

    @ViewBuilder fileprivate func clearFeed() -> some View {
        Section(Localizable.feedSettings.localized()) {
            Text(Localizable.clearFeed.localized())
                .onTapGesture {
                    vm.clearFeed()
                }
        }
    }

    @ViewBuilder fileprivate func chooseAppearance() -> some View {
        Section(Localizable.darkMode.localized()) {
            Picker(
                Localizable.appearance.localized(),
                selection: $vm.selectedAppearance
            ) {
                ForEach(Appearance.allCases) {
                    Text(
                        vm.getLocalizableForAppearance(appearance: $0)
                            .localized()
                    )
                    .tag($0)
                }
            }
            .pickerStyle(SegmentedPickerStyle())
        }
    }

    @ViewBuilder fileprivate func chooseLanguage() -> some View {
        Section(Localizable.chooseALanguage.localized()) {
            Picker("", selection: $vm.language) {
                ForEach(Language.allCases) {
                    Text(
                        vm.getLocalizableForLanguage(language: $0)
                            .localized()
                    ).tag($0)
                }
            }
            .pickerStyle(SegmentedPickerStyle())
        }
    }

    @ViewBuilder fileprivate func toggleNotifications() -> some View {
        Section("Notifications") {
            VStack {
//                Button("Send Test Notification") {
//                    Task {
//                        let isEnabled =
//                            await NotificationManager.isNotificationsEnabled()
//                        if isEnabled {
//                            await NotificationManager.scheduleLocalNotification(
//                                id: "test_notification",
//                                title: "Meeting Reminder",
//                                body:
//                                    "You have a meeting invitation. Check your app for details.",
//                                interval: 5
//                            )
//                        } else {
//                            showAlert = true
//                        }
//                    }
//                }
                Button("Manage Notifications") {
                    vm.openAppSettings()
                }
            }
        }
    }
}

#Preview {
    SettingsPage()
}
