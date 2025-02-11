//
//  MainViewModel.swift
//  RSSFeedProject
//
//  Created by Matej Persic on 08.02.2025..
//

import SwiftUI

class MainViewModel: BaseViewModel {
    @AppStorage("language") var language = LocalizationService.shared.language

}
