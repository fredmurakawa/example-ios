//
//  NewsFeedCellViewModelTests.swift
//  frederico-murakawa-iosTests
//
//  Created by Frederico Murakawa on 3/30/20.
//  Copyright © 2020 Frederico Murakawa. All rights reserved.
//

import XCTest
@testable import frederico_murakawa_ios

class NewsFeedCellViewModelTests: XCTestCase {
    var sut: NewsFeedCellViewModel!
    var article: Article!

    override func setUp() {
        let bundle = Bundle(for: type(of: self))
        let url = bundle.url(forResource: "cheesecakelabs", withExtension: "json")!
        let data = try! Data(contentsOf: url)

        let decoder = JSONDecoder()
        article = try! decoder.decode([Article].self, from: data).first!
        sut = NewsFeedCellViewModel(article: article)
    }

    override func tearDown() {
        sut = nil
        article = nil
    }

    func testTitle() {
        XCTAssertEqual(sut.title, "Obama Offers Hopeful Vision While Noting Nation's Fears")
    }

    func testWebsite() {
        XCTAssertEqual(sut.website, "MacStories")
    }

    func testAuthors() {
        XCTAssertEqual(sut.authors, "Graham Spencer")
    }

    func testDate() {
        XCTAssertEqual(sut.date, "05/26/2014")
    }

    func testContent() {
        XCTAssertEqual(sut.content, "In his last State of the Union address, President Obama sought to paint a hopeful portrait. But he acknowledged that many Americans felt shut out of a political and economic system they view as rigged.")
    }

    func testTags() {
        XCTAssertEqual(sut.tags.first!.id, 1)
        XCTAssertEqual(sut.tags.first!.label, "Politics")
    }

    func testImageURL() {
        XCTAssertEqual(sut.imageURL, "http://res.cloudinary.com/cheesecakelabs/image/upload/v1488993901/challenge/news_01_illh01.jpg")
    }

    func testmarkArticleAsReadOrUnread() {
        XCTAssertEqual(sut.read, false)
        sut.markArticleAsReadOrUnread()
        XCTAssertEqual(sut.read, true)
    }

    func testContextualActionImage() {
        XCTAssertEqual(sut.contextualActionImage, "envelope.open.fill")
        sut.markArticleAsReadOrUnread()
        XCTAssertEqual(sut.contextualActionImage, "envelope.fill")
    }

    func testContextualActionTitle() {
        XCTAssertEqual(sut.contextualActionTitle, "Read")
        sut.markArticleAsReadOrUnread()
        XCTAssertEqual(sut.contextualActionTitle, "Unread")
    }
}
