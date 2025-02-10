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

    func getRSSFeed() async -> Result<[FeedModel], any Error> {
        return await feedRepository.getRSSFeed()
    }

    func addFavoriteToFeed(feed: FeedModel) async -> Result<Void, any Error> {
        return await feedRepository.addFavoriteToFeed(feed: feed)
    }

    func removeItemFromFeed(at offset: IndexSet) async -> Result<
        Void, any Error
    > {
        return await feedRepository.removeItemFromFeed(at: offset)
    }

    func getCachedRSSFeed() async -> Result<[FeedModel], any Error> {
        return await feedRepository.getCachedRSSFeed()
    }

    func setCachedRSSFeed(feeds: [FeedModel]) async {
        return await feedRepository.setCachedRSSFeed(feeds: feeds)
    }

    func getDifferentItems() async -> [FeedItemModel] {
        let newFeedResult = await getRSSFeed()
        let cachedFeedResult = await getCachedRSSFeed()

        switch (newFeedResult, cachedFeedResult) {
        case (.success(let newFeed), .success(let cachedFeed)):
            var newOrUpdatedItems: [FeedItemModel] = []

            for newFeedModel in newFeed {
                if let cachedFeedModel = cachedFeed.first(where: {
                    $0.title == newFeedModel.title
                }) {
                    for newItem in newFeedModel.items ?? [] {
                        if let cachedItem = cachedFeedModel.items?.first(
                            where: { $0.title == newItem.title })
                        {
                            if newItem.date != cachedItem.date
                                || newItem.description != cachedItem.description
                            {
                                newOrUpdatedItems.append(newItem)
                            }
                        } else {
                            newOrUpdatedItems.append(newItem)
                        }
                    }
                } else {
                    newOrUpdatedItems.append(
                        contentsOf: newFeedModel.items ?? [])
                }
            }
            await feedRepository.setCachedRSSFeed(feeds: newFeed)
            return newOrUpdatedItems

        case (.failure(_), _):
            return []

        case (_, .failure(_)):
            return []
        }
    }
}
