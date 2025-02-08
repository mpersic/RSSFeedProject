//
//  Language.swift
//  RSSFeedProject
//
//  Created by Matej Persic on 08.02.2025..
//

import Foundation

enum Language: String, CaseIterable, Identifiable {
    case english = "en"
    case croatian = "hr"

    var id: String { self.rawValue }

}
