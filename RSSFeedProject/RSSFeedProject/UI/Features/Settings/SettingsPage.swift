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
            Section("Feed settings") {
                Text("Clear feed")
                    .onTapGesture {
                        vm.clearFeed()
                    }
            }
            
            Section(Localizable.darkMode.localized()) {
                Picker("Appearance", selection: $vm.selectedAppearance) {
                    ForEach(Appearance.allCases) { mode in
                        Text(mode.rawValue).tag(mode)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
            }
            
            Section("Select a language") {
                Picker("Language", selection: $vm.language) {
                    ForEach(Language.allCases) { mode in
                        Text(mode.rawValue).tag(mode)
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
