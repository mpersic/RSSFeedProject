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
            Section(Localizable.feedSettings.localized()) {
                Text(Localizable.clearFeed.localized())
                    .onTapGesture {
                        vm.clearFeed()
                    }
            }

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
    }
}

#Preview {
    SettingsPage()
}
