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

    var body: some View {
        List {
            headerInputView()

            favoritesView()

            feedView()
        }
        .uses(vm.alertManager)
        .refreshable {
            Task {
                await vm.loadFeeds()
            }
        }
        .animation(.default, value: vm.feeds)
    }

    @ViewBuilder fileprivate func headerInputView() -> some View {
        Section(Localizable.enterYourNewFeed.localized()) {
            TextField("", text: $vm.userInput)
                .onSubmit(addToFeedTask)
                .placeholder(when: vm.userInput.isEmpty) {
                    Text(Localizable.rssLink.localized())
                }
        }
    }

    @ViewBuilder fileprivate func favoritesView() -> some View {
        if !vm.favorites.isEmpty {
            Section(Localizable.yourFavorites.localized()) {
                ForEach(vm.favorites, id: \.title) { feed in
                    NavigationLink(
                        destination: FeedItemSelectionPage(feed: feed)
                    ) {
                        Text(feed.title ?? "")
                    }
                }
            }
        }
    }

    @ViewBuilder fileprivate func feedView() -> some View {
        if vm.feeds.isEmpty {
            Text(Localizable.noFeedsAddedAddYourFeedsAbove.localized())
        } else {
            Section(Localizable.yourFeeds.localized()) {
                ForEach(vm.feeds, id: \.title) { feed in
                    NavigationLink(
                        destination: FeedItemSelectionPage(feed: feed)
                    ) {
                        SelectFeedItemCell(
                            feed: feed,
                            addToFavorites: {
                                await vm.addFavorite(newItem: $0)
                            })
                    }
                }
                .onDelete {
                    vm.removeFeed(at: $0)
                }
            }
        }
    }

    fileprivate func addToFeedTask() {
        Task {
            await vm.addToFeed()
        }
    }
}

#Preview {
    SelectFeedPage()
}
