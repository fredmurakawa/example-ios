//
//  ArticleDetailsViewModelTests.swift
//  frederico-murakawa-iosTests
//
//  Created by Frederico Murakawa on 3/31/20.
//  Copyright © 2020 Frederico Murakawa. All rights reserved.
//

import XCTest
@testable import frederico_murakawa_ios

class ArticleDetailsViewModelTests: XCTestCase {

    var sut: ArticleDetailsViewModel!
    var article: Article!
    var coreDataStack: CoreDataStack!

    override func setUp() {
        coreDataStack = CoreDataStack(modelName: "Article")
        let data = loadStubFromBundle()

        let decoder = JSONDecoder()
        decoder.userInfo[CodingUserInfoKey.context!] = coreDataStack.managedContext
        article = try! decoder.decode([Article].self, from: data).first!
        sut = ArticleDetailsViewModel(article: article)
    }

    override func tearDown() {
        sut = nil
        article = nil
        coreDataStack = nil
    }

    func testWebsite() {
        XCTAssertEqual(sut.website, "Website: MacStories")
    }

    func testContent() {
        XCTAssertEqual(sut.content, "In his last State of the Union address, President Obama sought to paint a hopeful portrait. But he acknowledged that many Americans felt shut out of a political and economic system they view as rigged.")
    }

    func testTagsLabel() {
        XCTAssertEqual(sut.tagsLabel(), "Tags: Politics")
    }

}
