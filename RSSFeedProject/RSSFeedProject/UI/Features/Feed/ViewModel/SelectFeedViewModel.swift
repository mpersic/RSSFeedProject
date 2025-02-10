//
//  MainViewModel.swift
//  RSSFeedProject
//
//  Created by Matej Persic on 08.02.2025..
//

import Factory
import FeedKit
import Foundation

class SelectFeedViewModel: ObservableObject {

    @Published var feeds: [FeedModel] = [] {
        didSet {
            onMain { [self] in
                favorites = feeds.filter { $0.isFavorite }
            }
        }
    }
    @Published var favorites: [FeedModel] = []
    @Published var userInput = ""
    @Injected(\.feedRepository) private var feedRepository

    init() {
        Task {
            await loadFeeds()
        }
    }

    func addFavorite(newItem: FeedModel) async {
        var copy = newItem
        copy.isFavorite.toggle()
        Task {
            let result = await feedRepository.addFavoriteToFeed(
                feed: copy)
            switch result {
            case .success(_):
                await loadFeeds()
            case .failure(let error):
                print("Error adding to favorites: \(error)")
            }
        }
    }

    func addToFeed() async {
        let result = await feedRepository.addNewRSSFeed(
            feed: userInput)
        switch result {
        case .success(let fetchedFeed):
            onMain { [self] in
                feeds.append(fetchedFeed)
            }
        case .failure(let error):
            print("Error loading feed: \(error)")
        }
    }

    func loadFeeds() async {
        onMain { [self] in
            feeds = []
        }
        let result = await feedRepository.getSelectedRSSFeed()
        switch result {
        case .success(let fetchedFeed):
            onMain { [self] in
                feeds.append(contentsOf: fetchedFeed)
            }
        case .failure(let error):
            print("Error loading feeds: \(error)")
        }
    }

    func removeFeed(at offset: IndexSet) {
        Task {
            let result = await feedRepository.removeItemFromFeed(at: offset)
            switch result {
            case .success():
                await loadFeeds()
            case .failure(let error):
                print("Error loading feeds: \(error)")
            }
        }
    }
}
