//
//  FeedModel.swift
//  RSSFeedProject
//
//  Created by Matej Persic on 08.02.2025..
//

import FeedKit
import Foundation

struct FeedModel: Equatable, Codable {
    // MARK: - Properties
    var title: String?
    var date: Date?
    var description: String?
    var items: [FeedItemModel]?
    var isFavorite: Bool = false
    var link: String? = ""
    var imageUrl: String?

    // MARK: - Coding Keys
    private enum CodingKeys: String, CodingKey {
        case title, date, description, items, isFavorite, link, imageUrl
    }

    // MARK: - Initializers
    init() {}

    init(feed: RSSFeed) {
        title = feed.title
        date = feed.pubDate
        description = feed.description
        items = feed.items?.compactMap { feedItem in
            FeedItemModel(feedItem: feedItem)
        }
        link = feed.link
        imageUrl = feed.image?.link
    }

    init(feed: AtomFeed) {
        title = feed.title
        date = feed.updated
        description = feed.updated?.description
        items = feed.entries?.compactMap { entry in
            FeedItemModel(feedItem: entry)
        }
        imageUrl = feed.icon
    }

    init(feed: JSONFeed) {
        title = feed.title
        description = feed.description
        items = feed.items?.compactMap { jsonItem in
            FeedItemModel(feedItem: jsonItem)
        }
        link = feed.feedUrl
        imageUrl = feed.icon
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

    // MARK: - Custom Encoding & Decoding for Date
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        title = try container.decodeIfPresent(String.self, forKey: .title)
        description = try container.decodeIfPresent(
            String.self, forKey: .description)
        items = try container.decodeIfPresent(
            [FeedItemModel].self, forKey: .items)
        isFavorite = try container.decodeIfPresent(Bool.self, forKey: .isFavorite) ?? false
        if let dateString = try container.decodeIfPresent(
            String.self, forKey: .date)
        {
            date = DateFormatter.defaultFormat.date(from: dateString)
        }
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encodeIfPresent(title, forKey: .title)
        try container.encodeIfPresent(description, forKey: .description)
        try container.encodeIfPresent(items, forKey: .items)
        try container.encodeIfPresent(isFavorite, forKey: .isFavorite)

        if let date = date {
            try container.encode(
                DateFormatter.defaultFormat.string(from: date), forKey: .date)
        }
    }
}
