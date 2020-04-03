//
//  NewsFeedViewModelTests.swift
//  frederico-murakawa-iosTests
//
//  Created by Frederico Murakawa on 3/30/20.
//  Copyright © 2020 Frederico Murakawa. All rights reserved.
//

import XCTest
@testable import frederico_murakawa_ios

class NewsFeedViewModelTests: XCTestCase {
    var sut: NewsFeedViewModel!
    var coreDataStack: CoreDataStack!

    override func setUp() {
        let mockAPISession = MockAPISession()
        let articlesProvider = ArticlesProvider(apiSession: mockAPISession)
        coreDataStack = CoreDataStack(modelName: "Article")
        sut = NewsFeedViewModel(articlesProvider: articlesProvider, coreDataStack: coreDataStack)
        sut.loadArticles()
    }

    override func tearDown() {
        sut = nil
        coreDataStack = nil
    }

    func testNumberOfRowsInSection() {
        XCTAssertEqual(sut.numberOfRowsInSection, 6)
    }

    func testGetArticle() {
        XCTAssertEqual(sut.getArticle(at: 0).title, "NASA Formalizes Efforts To Protect Earth From Asteroids")
    }

    func testCellViewModelForArticle() {
        XCTAssertEqual(sut.cellViewModelForArticle(at: 0).title, "NASA Formalizes Efforts To Protect Earth From Asteroids")
    }

    func testSortArticles_byDate() {
        sut.sortArticles(by: .date)
        let firstArticle = sut.getArticle(at: 0)
        XCTAssertEqual(firstArticle.title, "NASA Formalizes Efforts To Protect Earth From Asteroids")
        let lastArticle = sut.getArticle(at: sut.numberOfRowsInSection - 1)
        XCTAssertEqual(lastArticle.title, "Picking a Windows 10 Security Package")
    }

    func testSortArticles_byTitle() {
        sut.sortArticles(by: .title)
        let firstArticle = sut.getArticle(at: 0)
        XCTAssertEqual(firstArticle.title, "As U.S. Modernizes Nuclear Weapons, 'Smaller' Leaves Some Uneasy")
        let lastArticle = sut.getArticle(at: sut.numberOfRowsInSection - 1)
        XCTAssertEqual(lastArticle.title, "Picking a Windows 10 Security Package")
    }

    func testSortArticles_byAuthor() {
        sut.sortArticles(by: .author)
        let firstArticle = sut.getArticle(at: 0)
        XCTAssertEqual(firstArticle.title, "NASA Formalizes Efforts To Protect Earth From Asteroids")
        let lastArticle = sut.getArticle(at: sut.numberOfRowsInSection - 1)
        XCTAssertEqual(lastArticle.title, "As U.S. Modernizes Nuclear Weapons, 'Smaller' Leaves Some Uneasy")
    }

    func testOnArticlesLoaded() {
        var testValue = 0
        let finalValue = 10
        sut.onArticlesLoaded = {
            testValue = 10
        }
        sut.onArticlesLoaded()
        XCTAssertEqual(testValue, finalValue)
    }

    func testOnLoadFailed() {
        var testValue = 0
        let finalValue = 50
        sut.onLoadFailed = {
            testValue += 50
        }
        sut.onLoadFailed()
        XCTAssertEqual(testValue, finalValue)
    }
}
