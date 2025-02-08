//
//  ContentView.swift
//  RSSFeedProject
//
//  Created by Matej Persic on 08.02.2025..
//

import Factory
import FeedKit
import SwiftUI

struct MainView: View {
    @InjectedObject(\.mainVM) private var vm
    @FocusState private var focusedField: FocusedField?

    var body: some View {
        NavigationStack {
            List {
                Section("Enter field") {
                    CustomTextField(
                        text: $vm.searchText,
                        focusedField: _focusedField,
                        field: .rssInput,
                        placeholder: "Rss link",
                        onSubmit: {
                            Task {
                                await vm.addFeed()
                            }
                        })
                }

                Section("Feeds") {
                    ForEach(vm.feeds, id: \.title) { feed in
                        NavigationLink(destination: FeedView(feed: feed)) {
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
            .navigationTitle("Concurrency")
            .animation(.default, value: vm.feeds)
        }
    }
}

#Preview {
    MainView()
}
