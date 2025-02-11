//
//  RSSFeedProjectTests.swift
//  RSSFeedProjectTests
//
//  Created by Matej Persic on 11.02.2025..
//

import XCTest
import FeedKit
@testable import RSSFeedProject

class FeedRepositoryTests: XCTestCase {
    var service: FeedServiceProtocol!
    var repository: MockFeedRepository!

    override func setUp() {
        super.setUp()
        repository = MockFeedRepository()
        service = FeedService(feedRepository: repository)
    }
    
    override func tearDown() {
        repository = nil
        service = nil
        super.tearDown()
    }

    func testGetRSSFeedSuccess() async {
        let expectedFeeds = [FeedModel(feed: RSSFeed())]
        repository.mockResult = .success(expectedFeeds)

        let result = await service.getRSSFeed()
        
        switch result {
        case .success(let feeds):
            XCTAssertEqual(feeds.count, 1)
            XCTAssertEqual(feeds.first?.title, nil)
        case .failure:
            XCTFail("Expected success but got failure")
        }
    }

    func testAddNewRSSFeedFailure() async {
        repository.mockAddFeedResult = .failure(NSError(domain: "MockError", code: 1))

        let result = await service.addNewRSSFeed(feed: "Invalid URL")
        
        switch result {
        case .success:
            XCTFail("Expected failure but got success")
        case .failure(let error):
            XCTAssertNotNil(error)
        }
    }
}
