//
//  BaseViewModel.swift
//  RSSFeedProject
//
//  Created by Matej Persic on 10.02.2025..
//

import AlertKit
import Foundation
import SwiftUI

class BaseViewModel: ObservableObject {
    @ObservedObject var alertManager = AlertManager()
    @ObservedObject var networkMonitor = NetworkMonitor.shared
    @AppStorage("appearance") var selectedAppearance: Appearance = .system

    func getIsConnectedToInternet() -> Bool {
        return networkMonitor.isConnected
    }

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
