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
            if let description = feed.description, !description.trim().isEmpty {
                Section(Localizable.description.localized()) {
                    Text(description)
                    if let imageUrl = feed.imageUrl {
                        AsyncImage(url: URL(string: imageUrl)) { image in
                            image.resizable()
                        } placeholder: {
                            ProgressView()
                        }
                        .scaledToFit()
                        .frame(width: Dimensions.imageFrameWidth)
                        .clipShape(.rect(cornerRadius: Dimensions.cornerRadius))
                    }
                }
            }
            if let link = feed.link, let url = URL(string: link) {
                Section(Localizable.link.localized()) {
                    Link(
                        Localizable.openInBrowser.localized(), destination: url
                    )
                    .foregroundColor(Colors.blue)
                }
            }

            Section(Localizable.items.localized()) {
                ForEach(feed.items ?? [], id: \.title) { item in
                    NavigationLink(destination: FeedItemDetailsPage(item: item))
                    {
                        Text(item.title ?? "-")
                    }
                }
            }
        }
        .listStyle(.automatic)
    }
}
