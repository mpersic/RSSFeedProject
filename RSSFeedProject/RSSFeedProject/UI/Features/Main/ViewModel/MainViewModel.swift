//
//  MainViewModel.swift
//  RSSFeedProject
//
//  Created by Matej Persic on 08.02.2025..
//

import SwiftUI

class MainViewModel: ObservableObject {
    @AppStorage("appearance") var selectedAppearance: Appearance = .system
    @AppStorage("language") var language = LocalizationService.shared.language

    var colorScheme: ColorScheme? {
        switch selectedAppearance {
        case .light:
            return .light
        case .dark:
            return .dark
        case .system:
            return nil
        }
    }
}
