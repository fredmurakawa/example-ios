//
//  XCTestCase.swift
//  frederico-murakawa-iosTests
//
//  Created by Frederico Murakawa on 3/31/20.
//  Copyright © 2020 Frederico Murakawa. All rights reserved.
//

import XCTest

extension XCTestCase {
    func loadStubFromBundle() -> Data {
        let bundle = Bundle(for: type(of: self))
        let url = bundle.url(forResource: "cheesecakelabs", withExtension: "json")!
        return try! Data(contentsOf: url)
    }
}
