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
    var coreDataStack: CoreDataStack!

    override func setUp() {
        coreDataStack = CoreDataStack(modelName: "Article")
        let data = loadStubFromBundle()

        let decoder = JSONDecoder()
        decoder.userInfo[CodingUserInfoKey.context!] = coreDataStack.managedContext
        article = try! decoder.decode([Article].self, from: data).first!
        sut = NewsFeedCellViewModel(article: article)
    }

    override func tearDown() {
        sut = nil
        article = nil
        coreDataStack = nil
    }

    func testTitle() {
        XCTAssertEqual(sut.title, "Obama Offers Hopeful Vision While Noting Nation's Fears")
    }

    func testAuthors() {
        XCTAssertEqual(sut.authors, "Graham Spencer")
    }

    func testDate() {
        XCTAssertEqual(sut.date, "05/26/2014")
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
        XCTAssertEqual(sut.contextualActionTitle, "Mark as Read")
        sut.markArticleAsReadOrUnread()
        XCTAssertEqual(sut.contextualActionTitle, "Mark as Unread")
    }
}
