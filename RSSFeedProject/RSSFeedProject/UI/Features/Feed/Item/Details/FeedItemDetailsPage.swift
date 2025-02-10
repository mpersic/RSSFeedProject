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
            Section("Title") {
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
            Section("Date") {
                Text(item.date?.description ?? "-")
            }
            Section("Description") {
                Text(item.description ?? "-")
            }
            if let link = item.link, let url = URL(string: link) {
                Section("Link") {
                    Link("Open in Browser", destination: url)
                        .foregroundColor(.blue)
                }
            }
        }.listStyle(.automatic)
    }
}
