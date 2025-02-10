//
//  FeedRepository.swift
//  RSSFeedProject
//
//  Created by Matej Persic on 08.02.2025..
//

import FeedKit
import Foundation

class FeedRepository: FeedRepositoryProtocol {

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

    func addFavoriteToFeed(feed: FeedModel) async -> Result<Void, any Error> {
        let result = await addToFeed(feed: feed)
        switch result {
        case .success(_):
            return .success(())
        case .failure(let failure):
            return .failure(failure)
        }
    }
    
    func removeItemFromFeed(at offset: IndexSet) async -> Result<Void, any Error> {
        let result = await getSelectedRSSFeed()
        switch result {
        case .success(let feedResult):
            do {
                var newFeed = feedResult
                newFeed.remove(atOffsets: offset)
                let encodedData = try JSONEncoder().encode(newFeed)
                
                let documentsDirectory = try FileManager.default.url(
                    for: .documentDirectory, in: .userDomainMask,
                    appropriateFor: nil, create: false)
                let fileURL = documentsDirectory.appendingPathComponent(
                    feedFilename)
                try encodedData.write(to: fileURL)
                return .success(())}
            catch{
                return .failure(error)
            }
        case .failure(let failure):
            return .failure(failure)
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

                if let decodedFeeds = try? JSONDecoder().decode(
                    [FeedModel].self, from: data)
                {
                    return .success(decodedFeeds)
                }
            }
            return .success([])

        } catch {
            return .failure(error)
        }
    }
    
    private func addToFeed(feed: FeedModel) async -> Result<Void, Error> {
        let result = await getSelectedRSSFeed()
        switch result {
        case .success(let feedResult):
            do {
                var newFeed = feedResult

                if let index = newFeed.firstIndex(where: {
                    $0.title == feed.title
                }) {
                    newFeed[index].isFavorite = feed.isFavorite
                    print("Toggled isFavorite for existing feed: \(feed.title ?? "Unknown Title")"
                    )
                } else {
                    newFeed.append(feed)
                }
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
