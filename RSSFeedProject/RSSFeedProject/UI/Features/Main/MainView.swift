//
//  ContentView.swift
//  RSSFeedProject
//
//  Created by Matej Persic on 08.02.2025..
//

import Factory
import FeedKit
import SwiftUI

struct MainView: View {

    @InjectedObject(\.mainVM) private var vm

    var body: some View {
        NavigationStack {
            TabView {
                SelectFeedPage()
                    .tabItem {
                        Label(
                            Localizable.home.localized(vm.language),
                            systemImage: Images.newspaper)
                    }

                SettingsPage()
                    .tabItem {
                        Label(
                            Localizable.settings.localized(vm.language),
                            systemImage: Images.gearshape)
                    }
            }
            .navigationTitle(Localizable.rssViewer.localized(vm.language))
            .preferredColorScheme(vm.colorScheme)
        }
    }
}

#Preview {
    MainView()
}
