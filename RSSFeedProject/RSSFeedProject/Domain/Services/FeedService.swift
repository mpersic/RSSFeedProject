//
//  FeedService.swift
//  RSSFeedProject
//
//  Created by Matej Persic on 10.02.2025..
//

import Factory
import Foundation

class FeedService: FeedServiceProtocol {

    private var feedRepository: FeedRepositoryProtocol

    init(
        feedRepository: FeedRepositoryProtocol =
            Container.shared.feedRepository()
    ) {
        self.feedRepository = feedRepository
    }

    func addNewRSSFeed(feed: String) async -> Result<FeedModel, any Error> {
        return await feedRepository.addNewRSSFeed(feed: feed)
    }

    func clearAllSelectedRSSFeed() -> Result<Void, any Error> {
        return feedRepository.clearAllSelectedRSSFeed()
    }

    func getSelectedRSSFeed() async -> Result<[FeedModel], any Error> {
        return await feedRepository.getSelectedRSSFeed()
    }

    func addFavoriteToFeed(feed: FeedModel) async -> Result<Void, any Error> {
        return await feedRepository.addFavoriteToFeed(feed: feed)
    }

    func removeItemFromFeed(at offset: IndexSet) async -> Result<
        Void, any Error
    > {
        return await feedRepository.removeItemFromFeed(at: offset)
    }

}
