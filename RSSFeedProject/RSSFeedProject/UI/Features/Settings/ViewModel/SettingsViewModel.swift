//
//  SettingsViewModel.swift
//  RSSFeedProject
//
//  Created by Matej Persic on 08.02.2025..
//

import Factory
import Foundation
import SwiftUI

class SettingsViewModel: ObservableObject {
    @AppStorage("appearance") var selectedAppearance: Appearance =
        .system
    @AppStorage("language")
    var language = LocalizationService.shared.language
    @Injected(\.feedRepository) private var feedRepository

    func clearFeed() {
        let result = feedRepository.clearAllSelectedRSSFeed()
        switch result {
        case .failure(let failure):
            print(failure.localizedDescription)
        default:
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
            Localizable.croatian
        case .croatian:
            Localizable.english
        }
    }

}
