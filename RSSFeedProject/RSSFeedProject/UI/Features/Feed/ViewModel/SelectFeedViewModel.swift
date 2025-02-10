//
//  MainViewModel.swift
//  RSSFeedProject
//
//  Created by Matej Persic on 08.02.2025..
//

import Factory
import FeedKit
import Foundation

class SelectFeedViewModel: BaseViewModel {

    @Published var userInput = ""
    @Published var favorites: [FeedModel] = []
    @Published var feeds: [FeedModel] = [] {
        didSet {
            onMain { [self] in
                favorites = feeds.filter { $0.isFavorite }
            }
        }
    }
    @Injected(\.feedRepository) private var feedRepository

    override init() {
        super.init()
        Task {
            await loadFeeds()
        }
    }

    func addFavorite(newItem: FeedModel) async {
        var itemCopy = newItem
        itemCopy.isFavorite.toggle()
        Task {
            let result = await feedRepository.addFavoriteToFeed(
                feed: itemCopy)
            switch result {
            case .success(_):
                await loadFeeds()
            case .failure(let error):
                alertManager.show(
                    dismiss: .error(message: error.localizedDescription))
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
            alertManager.show(
                dismiss: .error(message: error.localizedDescription))
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
            alertManager.show(
                dismiss: .error(message: error.localizedDescription))
        }
    }

    func removeFeed(at offset: IndexSet) {
        Task {
            let result = await feedRepository.removeItemFromFeed(at: offset)
            switch result {
            case .success():
                await loadFeeds()
            case .failure(let error):
                alertManager.show(
                    dismiss: .error(message: error.localizedDescription))
            }
        }
    }
}
