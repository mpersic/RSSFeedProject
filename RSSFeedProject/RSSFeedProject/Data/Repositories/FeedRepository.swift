//
//  FeedRepository.swift
//  RSSFeedProject
//
//  Created by Matej Persic on 08.02.2025..
//

import FeedKit
import Foundation

class FeedRepository {
    
    func getFeed(feed: String) async -> Result<FeedModel, Error> {
        guard let url = URL(string: feed) else {
            return .failure(URLError(.badURL))
        }

        let parser = FeedParser(URL: url)
        let result = await parseFeedAsync(parser)

        switch result {
        case .success(let feed):
            return .success(FeedModel(feed: feed))
        case .failure(let error):
            return .failure(error)
        }
    }
    
    func getFeeds() async -> Result<[FeedModel], Error> {
        var feeds: [FeedModel] = []
        var firstError: Error?

        await withTaskGroup(of: Result<Feed, Error>.self) { group in
            for urlString in Constants.feedURLs {
                group.addTask { [self] in
                    guard let url = URL(string: urlString) else {
                        return .failure(URLError(.badURL))
                    }

                    let parser = FeedParser(URL: url)
                    return await parseFeedAsync(parser)
                }
            }

            for await result in group {
                switch result {
                case let .success(feed):
                    feeds.append(FeedModel(feed: feed))
                case let .failure(error):
                    if firstError == nil {
                        firstError = error
                    }
                    print("Failed to load feed: \(error)")
                }
            }
        }

        if !feeds.isEmpty {
            return .success(feeds)
        } else if let error = firstError {
            return .failure(error)
        } else {
            return .failure(URLError(.unknown))
        }
    }

    private func parseFeedAsync(_ parser: FeedParser) async -> Result<
        Feed, Error
    > {
        await withCheckedContinuation { continuation in
            parser.parseAsync { result in
                continuation.resume(returning: result.mapError { $0 as Error })
            }
        }
    }
}
