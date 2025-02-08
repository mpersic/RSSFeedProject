//
//  FeedRepository.swift
//  RSSFeedProject
//
//  Created by Matej Persic on 08.02.2025..
//

import FeedKit
import Foundation

class FeedRepository {

    private let feedFilename = "feed.json"

    func addNewRSSFeed(feed: String) async -> Result<FeedModel, Error> {
        guard let url = URL(string: feed) else {
            return .failure(URLError(.badURL))
        }

        let parser = FeedParser(URL: url)
        let result = await parseFeedAsync(parser)

        switch result {
        case .success(let feed):
            let newFeed = FeedModel(feed: feed)
            let addResult = await addToFeed(feed: newFeed)
            switch addResult {
            case .failure(let error):
                return .failure(error)
            default:
                return .success(newFeed)
            }
        case .failure(let error):
            return .failure(error)
        }
    }
    func clearAllSelectedRSSFeed() -> Result<Void, Error> {
        do {
            let emptyArray = [FeedModel]()
            let encodedData = try JSONEncoder().encode(emptyArray)

            let documentsDirectory = try FileManager.default.url(
                for: .documentDirectory, in: .userDomainMask,
                appropriateFor: nil, create: false)
            let fileURL = documentsDirectory.appendingPathComponent(
                feedFilename)

            try encodedData.write(to: fileURL)
            return .success(())

        } catch {
            return .failure(error)
        }
    }

    func getSelectedRSSFeed() async -> Result<[FeedModel], Error> {
        do {
            let documentsDirectory = try FileManager.default.url(
                for: .documentDirectory, in: .userDomainMask,
                appropriateFor: nil, create: false)
            let fileURL = documentsDirectory.appendingPathComponent(
                feedFilename)

            if FileManager.default.fileExists(atPath: fileURL.path) {
                let data = try Data(contentsOf: fileURL)

                // 1. Try decoding as an array first (most common case):
                if let decodedFeeds = try? JSONDecoder().decode(
                    [FeedModel].self, from: data)
                {
                    return .success(decodedFeeds)
                }

                // 2. If that fails, try decoding as a dictionary (for single feeds or keyed feeds):
                if let decodedDictionary = try? JSONDecoder().decode(
                    [String: FeedModel].self, from: data)
                {
                    let feeds = Array(decodedDictionary.values)  // Convert dictionary values to an array
                    return .success(feeds)
                }

                // 3. If that also fails, it might be a single FeedModel
                if let decodedFeed = try? JSONDecoder().decode(
                    FeedModel.self, from: data)
                {
                    return .success([decodedFeed])
                }

                // 3. If both fail, the data is corrupt or in an unexpected format:
                return .failure(
                    NSError(
                        domain: "YourAppDomain", code: 0,
                        userInfo: [
                            NSLocalizedDescriptionKey:
                                "Invalid feed data format."
                        ]))  // Provide a more specific error

            }
            return .success([])

        } catch {
            return .failure(error)
        }
    }

    //get feeds from urls
    /*func getFeeds() async -> Result<[FeedModel], Error> {
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
    }*/

    private func addToFeed(feed: FeedModel) async -> Result<Void, Error> {
        let result = await getSelectedRSSFeed()
        switch result {
        case .success(let feedResult):
            do {
                var newFeed = feedResult
                newFeed.append(feed)
                let encodedData = try JSONEncoder().encode(newFeed)

                let documentsDirectory = try FileManager.default.url(
                    for: .documentDirectory, in: .userDomainMask,
                    appropriateFor: nil, create: false)
                let fileURL = documentsDirectory.appendingPathComponent(
                    feedFilename)

                try encodedData.write(to: fileURL)
                return .success(())

            } catch {
                print("Error saving new feed: \(error)")
                return .failure(error)
            }
        case .failure(let error):
            print("Error getting selected feed: \(error)")
            return .failure(error)
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
