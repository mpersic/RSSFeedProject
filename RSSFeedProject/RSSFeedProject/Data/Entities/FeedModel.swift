//
//  FeedModel.swift
//  RSSFeedProject
//
//  Created by Matej Persic on 08.02.2025..
//

import FeedKit
import Foundation

struct FeedModel: Equatable {
    // MARK: Lifecycle

    init() {}

    init(feed: RSSFeed) {
        title = feed.title
        date = feed.pubDate
        description = feed.description
        items = feed.items?.compactMap { .init(item: $0) }
    }

    init(feed: JSONFeed) {
        title = feed.title
        description = feed.description
        items = feed.items?.compactMap { .init(item: $0) }
    }

    init(feed: AtomFeed) {
        title = feed.title
        date = feed.updated
        description = feed.updated?.description
        items = feed.entries?.compactMap { .init(item: $0) }
    }

    init(feed: Feed) {
        switch feed {
        case let .atom(atomFeed):
            self.init(feed: atomFeed)
        case let .rss(rssFeed):
            self.init(feed: rssFeed)
        case let .json(jsonFeed):
            self.init(feed: jsonFeed)
        }
    }

    // MARK: Internal

    var title: String?
    var date: Date?
    var description: String?
    var items: [FeedItemModel]?
}
