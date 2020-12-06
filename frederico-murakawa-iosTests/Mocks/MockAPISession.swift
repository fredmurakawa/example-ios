//
//  MockAPISessionProviding.swift
//  frederico-murakawa-iosTests
//
//  Created by Frederico Murakawa on 3/31/20.
//  Copyright © 2020 Frederico Murakawa. All rights reserved.
//

import Foundation
@testable import frederico_murakawa_ios

class MockAPISession: APISessionProviding {
    func fetch<T>(coreDataStack: CoreDataStack, _ requestProvider: RequestProviding, completion: @escaping (Result<T, Error>) -> Void) where T : Decodable {
        let bundle = Bundle(for: type(of: self))
        let url = bundle.url(forResource: "cheesecakelabs", withExtension: "json")!
        let data = try! Data(contentsOf: url)

        let decoder = JSONDecoder()
        decoder.userInfo[CodingUserInfoKey.context!] = coreDataStack.managedContext
        let articles = try! decoder.decode(T.self, from: data)
        completion(.success(articles))
    }
}
