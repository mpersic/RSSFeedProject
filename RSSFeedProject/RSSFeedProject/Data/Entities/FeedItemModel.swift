//
//  FeedItemModel.swift
//  RSSFeedProject
//
//  Created by Matej Persic on 08.02.2025..
//

import Foundation
import FeedKit

struct FeedItemModel: Equatable, Codable {
    var title: String?
    var description: String?
    var date: Date?
    var imageUrl: String?
    var link: String?

    private enum CodingKeys: String, CodingKey {
        case title, description, date, imageUrl, link
    }
    
    // MARK: - Initializers from FeedKit types
        init(feedItem: RSSFeedItem) {
            title = feedItem.title
            description = feedItem.description
            date = feedItem.pubDate
            imageUrl = feedItem.enclosure?.attributes?.url
            link = feedItem.link
        }

        init(feedItem: AtomFeedEntry) {
            title = feedItem.title
            description = feedItem.updated?.description
            date = feedItem.updated
            imageUrl = feedItem.links?.first?.attributes?.href
        }

        init(feedItem: JSONFeedItem) {
            title = feedItem.title
            description = feedItem.contentHtml ?? feedItem.contentText
            date = feedItem.datePublished
            imageUrl = feedItem.image
            link = feedItem.contentHtml
        }
    

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        title = try container.decodeIfPresent(String.self, forKey: .title)
        description = try container.decodeIfPresent(String.self, forKey: .description)
        imageUrl = try container.decodeIfPresent(String.self, forKey: .imageUrl)
        link = try container.decodeIfPresent(String.self, forKey: .link)

        if let dateString = try container.decodeIfPresent(String.self, forKey: .date) {
            date = DateFormatter.defaultFormat.date(from: dateString)
        }
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encodeIfPresent(title, forKey: .title)
        try container.encodeIfPresent(description, forKey: .description)
        try container.encodeIfPresent(imageUrl, forKey: .imageUrl)
        try container.encodeIfPresent(link, forKey: .link)

        if let date = date {
            try container.encode(DateFormatter.defaultFormat.string(from: date), forKey: .date)
        }
    }
}

