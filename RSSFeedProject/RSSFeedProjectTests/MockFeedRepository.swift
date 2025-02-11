//
//  MockFeedRepository.swift
//  RSSFeedProjectTests
//
//  Created by Matej Persic on 11.02.2025..
//

import XCTest
@testable import RSSFeedProject

class MockFeedRepository: FeedRepositoryProtocol {
    
    var mockFeeds: [FeedModel] = []
    var mockResult: Result<[FeedModel], Error> = .success([])
    var mockAddFeedResult: Result<FeedModel, Error> = .failure(NSError(domain: "MockError", code: 1))
    var mockVoidResult: Result<Void, Error> = .success(())
    
    func addNewRSSFeed(feed: String) async -> Result<FeedModel, Error> {
        return mockAddFeedResult
    }

    func clearAllSelectedRSSFeed() -> Result<Void, Error> {
        return mockVoidResult
    }

    func getRSSFeed() async -> Result<[FeedModel], Error> {
        return mockResult
    }

    func addFavoriteToFeed(feed: FeedModel) async -> Result<Void, Error> {
        return mockVoidResult
    }

    func removeItemFromFeed(at offset: IndexSet) async -> Result<Void, any Error> {
        return mockVoidResult
    }

    func getCachedRSSFeed() async -> Result<[FeedModel], Error> {
        return mockResult
    }

    func setCachedRSSFeed(feeds: [FeedModel]) async {
        mockFeeds = feeds
    }
}
