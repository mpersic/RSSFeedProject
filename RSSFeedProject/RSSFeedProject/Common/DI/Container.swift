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
    
    var selectFeedVM: Factory<SelectFeedViewModel> {
        self { SelectFeedViewModel() }
    }

    var settingsVM: Factory<SettingsViewModel> {
        self { SettingsViewModel() }
    }
}

// MARK: - register repositories

extension Container {
    var feedRepository: Factory<FeedRepositoryProtocol> {
        self { FeedRepository() }
    }
}
