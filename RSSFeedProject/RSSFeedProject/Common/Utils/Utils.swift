//
//  Utils.swift
//  RSSFeedProject
//
//  Created by Matej Persic on 08.02.2025..
//

import Foundation

func onMain(_ completion: @escaping EmptyCallback) {
    DispatchQueue.main.async {
        completion()
    }
}

func inBackground(_ completion: @escaping EmptyCallback) {
    DispatchQueue.global(qos: .background).async {
        completion()
    }
}
