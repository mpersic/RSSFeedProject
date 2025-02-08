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
        feedRepository.clearAllSelectedRSSFeed()
    }
}
