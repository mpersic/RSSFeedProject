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

    private enum CodingKeys: String, CodingKey {
        case title, description, date, imageUrl
    }
    
    // MARK: - Initializers from FeedKit types
        init(feedItem: RSSFeedItem) {
            title = feedItem.title
            description = feedItem.description
            date = feedItem.pubDate
            imageUrl = feedItem.enclosure?.attributes?.url// Example: Get image from enclosure
        }

        init(feedItem: AtomFeedEntry) {
            title = feedItem.title
            description = feedItem.updated?.description // Or content, if available
            date = feedItem.updated
            imageUrl = feedItem.links?.first?.attributes?.href // Example: Get image from link
        }

        init(feedItem: JSONFeedItem) {
            title = feedItem.title
            description = feedItem.contentHtml ?? feedItem.contentText // Prefer HTML, fallback to text
            date = feedItem.datePublished
            imageUrl = feedItem.image //Or other image related property
        }
    

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        title = try container.decodeIfPresent(String.self, forKey: .title)
        description = try container.decodeIfPresent(String.self, forKey: .description)
        imageUrl = try container.decodeIfPresent(String.self, forKey: .imageUrl)

        if let dateString = try container.decodeIfPresent(String.self, forKey: .date) {
            date = Self.dateFormatter.date(from: dateString)
        }
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encodeIfPresent(title, forKey: .title)
        try container.encodeIfPresent(description, forKey: .description)
        try container.encodeIfPresent(imageUrl, forKey: .imageUrl)

        if let date = date {
            try container.encode(Self.dateFormatter.string(from: date), forKey: .date)
        }
    }

    private static let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        formatter.locale = Locale(identifier: "en_US_POSIX")
        return formatter
    }()
}

