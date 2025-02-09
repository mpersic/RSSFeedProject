//
//  SelectFeedItemCell.swift
//  RSSFeedProject
//
//  Created by Matej Persic on 09.02.2025..
//

import SwiftUI

struct SelectFeedItemCell: View {
    let feed: FeedModel
    let addToFavorites: (FeedModel) async -> Void

    var body: some View {
        HStack {
            Text(feed.title ?? "")

            Spacer()

            Button(action: {
                Task {
                    await addToFavorites(feed)
                }
            }) {
                Image(systemName: feed.isFavorite ? "heart.fill" : "heart")
                    .foregroundColor(feed.isFavorite ? .blue : .gray)
            }
            .buttonStyle(PlainButtonStyle())
        }
    }
}
