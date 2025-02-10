//
//  FeedItemView.swift
//  RSSFeedProject
//
//  Created by Matej Persic on 08.02.2025..
//

import SwiftUI

struct FeedItemDetailsPage: View {
    let item: FeedItemModel
    private let imageFrameWidth = UIScreen.width * 0.8

    var body: some View {
        List {
            Section(Localizable.title.localized()) {
                Text(item.title ?? "-")
            }
            if let imageUrl = item.imageUrl {
                AsyncImage(url: URL(string: imageUrl)) { image in
                    image.resizable()
                } placeholder: {
                    ProgressView()
                }
                .scaledToFit()
                .frame(width: imageFrameWidth)
                .clipShape(.rect(cornerRadius: Dimensions.cornerRadius))
            }
            Section(Localizable.date.localized()) {
                Text(item.date?.description ?? "-")
            }
            Section(Localizable.description.localized()) {
                Text(item.description ?? "-")
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
