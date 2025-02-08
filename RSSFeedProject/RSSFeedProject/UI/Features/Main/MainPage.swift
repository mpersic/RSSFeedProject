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

    @InjectedObject(\.mainVM) private var vm

    var body: some View {
        NavigationStack {
            TabView {
                SelectFeedPage()
                    .tabItem {
                        Label(
                            Localizable.home.localized(vm.language),
                            systemImage: "newspaper.fill")
                    }

                SettingsPage()
                    .tabItem {
                        Label(
                            Localizable.settings.localized(vm.language),
                            systemImage: "gearshape.fill")
                    }
            }
            .navigationTitle(Localizable.rssViewer.localized(vm.language))
            .preferredColorScheme(vm.colorScheme)
        }
    }
}

#Preview {
    MainPage()
}
