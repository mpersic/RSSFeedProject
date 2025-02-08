//
//  FeedItemModel.swift
//  RSSFeedProject
//
//  Created by Matej Persic on 08.02.2025..
//

import FeedKit
import Foundation

struct FeedItemModel: Equatable {
    // MARK: Lifecycle

    init() {}

    init(item: RSSFeedItem) {
        title = item.title
        description = item.description
        date = item.pubDate
        image = item.iTunes?.iTunesImage
    }

    init(item: AtomFeedEntry) {
        title = item.title
        description = item.summary?.value
        date = item.published
    }

    init(item: JSONFeedItem) {
        title = item.title
        description = item.summary
        date = item.datePublished
        imageUrl = item.image
    }

    // MARK: Internal

    var title: String?
    var description: String?
    var date: Date?
    var imageUrl: String?
    var image: ITunesImage?
}
