//
//  SettingsViewModel.swift
//  RSSFeedProject
//
//  Created by Matej Persic on 08.02.2025..
//

import AlertKit
import Factory
import Foundation
import SwiftUI

class SettingsViewModel: BaseViewModel {
    @AppStorage("language")
    var language = LocalizationService.shared.language
    @Injected(\.feedService) private var feedService

    func clearFeed() {
        let result = feedService.clearAllSelectedRSSFeed()
        switch result {
        case .failure(let failure):
            alertManager.show(
                dismiss: .error(message: failure.localizedDescription))
        default:
            alertManager.show(
                dismiss: .success(message: Localizable.feedCleared.localized()))
            break
        }
    }

    func getLocalizableForAppearance(appearance: Appearance) -> String {
        switch appearance {
        case .system:
            Localizable.system
        case .light:
            Localizable.light
        case .dark:
            Localizable.dark
        }
    }

    func getLocalizableForLanguage(language: Language) -> String {
        switch language {
        case .english:
            Localizable.english
        case .croatian:
            Localizable.croatian
        }
    }

    func openAppSettings() {
        if let url = URL(string: UIApplication.openSettingsURLString) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }

}
