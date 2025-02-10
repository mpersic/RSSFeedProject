//
//  FeedView.swift
//  RSSFeedProject
//
//  Created by Matej Persic on 08.02.2025..
//

import FeedKit
import SwiftUI

struct FeedItemSelectionPage: View {
    let feed: FeedModel

    var body: some View {
        List {
            Section(Localizable.title.localized()) {
                Text(feed.title ?? "-")
            }
            Section(Localizable.description.localized()) {
                Text(feed.description ?? "-")
            }
            Section(Localizable.items.localized()) {
                ForEach(feed.items ?? [], id: \.title) { item in
                    NavigationLink(destination: FeedItemDetailsPage(item: item)) {
                        Text(item.title ?? "-")
                    }
                }
            }
        }
        .listStyle(.automatic)
    }
}
