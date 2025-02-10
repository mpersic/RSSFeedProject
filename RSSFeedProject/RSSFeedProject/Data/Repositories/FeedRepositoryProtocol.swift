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
    func getRSSFeed() async -> Result<[FeedModel], Error>
    func addFavoriteToFeed(feed: FeedModel) async -> Result<Void, Error>
    func removeItemFromFeed(at offset: IndexSet) async -> Result<Void, any Error>
    func getCachedRSSFeed() async -> Result<[FeedModel], Error>
    func setCachedRSSFeed(feeds: [FeedModel]) async 
}
