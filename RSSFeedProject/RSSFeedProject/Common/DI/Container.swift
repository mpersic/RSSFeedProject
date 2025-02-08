//
//  Container.swift
//  RSSFeedProject
//
//  Created by Matej Persic on 08.02.2025..
//

import Factory
import Foundation

// MARK: - register viewmodels

extension Container {
    var mainVM: Factory<MainViewModel> {
        self { MainViewModel() }
    }
    
    var settingsVM: Factory<SettingsViewModel> {
        self { SettingsViewModel() }
    }
}

// MARK: - register services

extension Container {
}

// MARK: - register repositories

extension Container {
    var feedRepository: Factory<FeedRepository> {
        self { FeedRepository() }
    }
}

// MARK: register coordinator

extension Container {
}
