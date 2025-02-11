//
//  FeedItemView.swift
//  RSSFeedProject
//
//  Created by Matej Persic on 08.02.2025..
//

import SwiftUI

struct FeedItemDetailsPage: View {
    let item: FeedItemModel

    var body: some View {
        List {
            Section("") {
                Text(item.title ?? "-")
                    .font(.title)

                if let imageUrl = item.imageUrl {
                    AsyncImage(url: URL(string: imageUrl)) { image in
                        image.resizable()
                    } placeholder: {
                        ProgressView()
                    }
                    .scaledToFit()
                    .frame(width: Dimensions.imageFrameWidth)
                    .clipShape(.rect(cornerRadius: Dimensions.cornerRadius))
                }

                Text(item.description?.trim() ?? "-")
                    .multilineTextAlignment(.leading)
            }
            Section(Localizable.date.localized()) {
                Text(item.date?.description ?? "-")
            }
            if let link = item.link, let url = URL(string: link) {
                Section(Localizable.link.localized()) {
                    Link(
                        Localizable.openInBrowser.localized(), destination: url
                    )
                    .foregroundColor(Colors.blue)
                }
            }
        }.listStyle(.automatic)
    }
}
