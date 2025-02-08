//
//  FeedPage.swift
//  RSSFeedProject
//
//  Created by Matej Persic on 08.02.2025..
//

import Factory
import SwiftUI

struct SelectFeedPage: View {

    @InjectedObject(\.selectFeedVM) private var vm
    @FocusState private var focusedField: FocusedField?

    var body: some View {
        List {
            Section(Localizable.enterYourNewFeed.localized()) {
                TextField("", text: $vm.searchText)
                    .onSubmit(addToFeedTask)
                CustomTextField(
                    text: $vm.searchText,
                    focusedField: _focusedField,
                    field: .rssInput,
                    placeholder: Localizable.rssLink.localized(),
                    onSubmit: addToFeedTask)
            }

            Section(Localizable.yourFeeds.localized()) {
                ForEach(vm.feeds, id: \.title) { feed in
                    NavigationLink(
                        destination: FeedItemSelectionPage(feed: feed)
                    ) {
                        Text(feed.title ?? "")
                    }
                }
                .onDelete {
                    vm.removeFeed(at: $0)
                }
            }
        }
        .refreshable {
            Task {
                await vm.loadFeeds()
            }
        }
        .onAppear {
            Task {
                if vm.feeds.isEmpty {
                    await vm.loadFeeds()
                }
            }
        }
        .animation(.default, value: vm.feeds)
    }

    private func addToFeedTask() {
        Task {
            await vm.addToFeed()
        }
    }
}

#Preview {
    SelectFeedPage()
}
