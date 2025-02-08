//
//  ContentView.swift
//  RSSFeedProject
//
//  Created by Matej Persic on 08.02.2025..
//

import Factory
import FeedKit
import SwiftUI

struct MainPage: View {

    @AppStorage("appearance") private var selectedAppearance: Appearance =
        .system
    @AppStorage("language")
    private var language = LocalizationService.shared.language
    
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

    var body: some View {
        NavigationStack {
            TabView {
                FeedPage()
                    .tabItem {
                        Label(Localizable.home.localized(language), systemImage: "newspaper.fill")
                    }

                SettingsPage()
                    .tabItem {
                        Label(
                            Localizable.settings.localized(language), systemImage: "gearshape.fill")
                    }
            }
            .navigationTitle("RSS Viewer")
            .preferredColorScheme(colorScheme)
        }
    }
}

#Preview {
    MainPage()
}
