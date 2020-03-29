//
//  NewsFeedViewModel.swift
//  frederico-murakawa-ios
//
//  Created by Frederico Murakawa on 3/28/20.
//  Copyright © 2020 Frederico Murakawa. All rights reserved.
//

import Foundation

public class NewsFeedViewModel {
    private let articlesProvider: ArticlesProviding
    private var articles: [Article] = []

    var onArticlesLoaded: () -> Void = {}

    var numberOfRowsInSection: Int { articles.count }

    init(articlesProvider: ArticlesProviding) {
        self.articlesProvider = articlesProvider
    }

    func loadArticles() {
        articlesProvider.getArticles { [weak self] result in
            do {
                self?.articles = try result.get()
                self?.onArticlesLoaded()
            } catch {
                #warning("Implement")
            }
        }
    }

    func cellViewModelForArticle(at index: Int) -> NewsFeedCellViewModel {
        let article = articles[index]
        return NewsFeedCellViewModel(article: article)
    }
}
