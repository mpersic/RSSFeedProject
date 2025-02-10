//
//  BaseViewModel.swift
//  RSSFeedProject
//
//  Created by Matej Persic on 10.02.2025..
//

import AlertKit
import Foundation
import SwiftUICore

class BaseViewModel: ObservableObject {
    @ObservedObject var alertManager = AlertManager()
}
