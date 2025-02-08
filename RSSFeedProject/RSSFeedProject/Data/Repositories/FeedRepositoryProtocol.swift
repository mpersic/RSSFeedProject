//
//  FeedRepositoryProtocol.swift
//  RSSFeedProject
//
//  Created by Matej Persic on 08.02.2025..
//

import Foundation

protocol FeedRepositoryProtocol {

    func addNewRSSFeed(feed: String) async -> Result<FeedModel, Error>
    func clearAllSelectedRSSFeed() -> Result<Void, Error>
    func getSelectedRSSFeed() async -> Result<[FeedModel], Error>

}
