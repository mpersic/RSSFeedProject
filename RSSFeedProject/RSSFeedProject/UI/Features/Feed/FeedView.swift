//
//  FeedView.swift
//  RSSFeedProject
//
//  Created by Matej Persic on 08.02.2025..
//

import FeedKit
import SwiftUI

struct FeedView: View {
    let feed: FeedModel

    var body: some View {
        List {
            Section("Title") {
                Text(feed.title ?? "-")
            }
            Section("Description") {
                Text(feed.description ?? "-")
            }
            Section("Items") {
                ForEach(feed.items ?? [], id: \.title) { item in
                    NavigationLink(destination: FeedItemView(item: item)) {
                        Text(item.title ?? "-")
                    }
                }
            }
        }
        .listStyle(.automatic)
    }
}
