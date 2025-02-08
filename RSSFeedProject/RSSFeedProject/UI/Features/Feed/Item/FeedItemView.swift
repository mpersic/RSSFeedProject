//
//  FeedItemView.swift
//  RSSFeedProject
//
//  Created by Matej Persic on 08.02.2025..
//

import SwiftUI

struct FeedItemView: View {
    let item: FeedItemModel

    var body: some View {
        List {
            Section("Title") {
                Text(item.title ?? "-")
            }
            Section("Date") {
                Text(item.date?.description ?? "-")
            }
            Section("Description") {
                Text(item.description ?? "-")
            }
            if let imageUrl = item.imageUrl {
                AsyncImage(url: URL(string: imageUrl)) { image in
                    image.resizable()
                } placeholder: {
                    Color.red
                }
                .frame(width: 128, height: 128)
                .clipShape(.rect(cornerRadius: 25))
            }
        }.listStyle(.automatic)
    }
}
