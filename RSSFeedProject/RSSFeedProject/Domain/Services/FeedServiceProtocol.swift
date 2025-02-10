//
//  FeedServiceProtocol.swift
//  RSSFeedProject
//
//  Created by Matej Persic on 10.02.2025..
//

import Foundation

protocol FeedServiceProtocol {

    func addNewRSSFeed(feed: String) async -> Result<FeedModel, Error>
    func clearAllSelectedRSSFeed() -> Result<Void, Error>
    func getSelectedRSSFeed() async -> Result<[FeedModel], Error>
    func addFavoriteToFeed(feed: FeedModel) async -> Result<Void, Error>
    func removeItemFromFeed(at offset: IndexSet) async -> Result<Void, any Error>
}
