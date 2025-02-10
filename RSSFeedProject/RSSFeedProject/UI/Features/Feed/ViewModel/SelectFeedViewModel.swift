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

    @Injected(\.feedRepository) private var feedRepository
    @Published var feeds: [FeedModel] = [] {
        didSet {
            onMain { [self] in
                favorites = feeds.filter { $0.isFavorite }
            }
        }
    }
    @Published var favorites: [FeedModel] = []
    @Published var searchText = ""

    init() {
        /*Task {
            searchText = "https://www.9to5mac.com/feed/"
            await addToFeed()
            searchText = "https://www.digitaltrends.com/feed/"
            await addToFeed()
        }*/
    }

    func addFavorite(newItem: FeedModel) async {
        var copy = newItem
        copy.isFavorite.toggle()
        Task {
            let result = await feedRepository.addFavoriteToFeed(
                feed: copy)
            switch result {
            case .success(let fetchedFeed):
                await loadFeeds()
            case .failure(let error):
                print("Error adding to favorites: \(error)")
            }
        }
    }

    func addToFeed() async {
        let result = await feedRepository.addNewRSSFeed(
            feed: searchText)
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
        onMain { [self] in
            feeds.remove(atOffsets: offset)
        }
    }

    //    func loadFeeds() async {
    //        onMain { [self] in
    //            feeds = []
    //        }
    //
    //        let result = await feedRepository.getFeeds()
    //
    //        switch result {
    //        case .success(let fetchedFeeds):
    //            onMain { [self] in
    //                feeds = fetchedFeeds
    //            }
    //        case .failure(let error):
    //            print("Error loading feeds: \(error)")
    //        }
    //    }
}
