//
//  ArticlesProvider.swift
//  frederico-murakawa-ios
//
//  Created by Frederico Murakawa on 3/27/20.
//  Copyright © 2020 Frederico Murakawa. All rights reserved.
//

import Foundation

protocol ArticlesProviding {
    var apiSession: APISessionProviding { get }
    
    func getArticles(coreDataStack: CoreDataStack, _ completion: @escaping (Result<[Article], Error>) -> Void)
}

struct ArticlesProvider: ArticlesProviding {
    let apiSession: APISessionProviding
    
    init(apiSession: APISessionProviding) {
        self.apiSession = apiSession
    }
    
    func getArticles(coreDataStack: CoreDataStack, _ completion: @escaping (Result<[Article], Error>) -> Void) {
        apiSession.fetch(coreDataStack: coreDataStack, Endpoint.articles, completion: completion)
    }
}
