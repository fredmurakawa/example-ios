//
//  NewsFeedViewModel.swift
//  frederico-murakawa-ios
//
//  Created by Frederico Murakawa on 3/28/20.
//  Copyright © 2020 Frederico Murakawa. All rights reserved.
//

import Foundation

enum SortType {
    case title, date, author
}

final class NewsFeedViewModel {
    private let articlesProvider: ArticlesProviding
    private var articles: [Article] = []

    var onArticlesLoaded: () -> Void = {}
    var onLoadFailed: () -> Void = {}

    var numberOfRowsInSection: Int { articles.count }

    init(articlesProvider: ArticlesProviding) {
        self.articlesProvider = articlesProvider
    }

    func loadArticles() {
        articlesProvider.getArticles { [weak self] result in
            do {
                self?.articles = try result.get()
                self?.sortArticles(by: .date)
                self?.onArticlesLoaded()
            } catch {
                print(error.localizedDescription)
                self?.onLoadFailed()
            }
        }
    }

    func cellViewModelForArticle(at index: Int) -> NewsFeedCellViewModel {
        let article = articles[index]
        return NewsFeedCellViewModel(article: article)
    }

    func sortArticles(by sortType: SortType) {
        switch sortType {
        case .title:
            articles = articles.sorted { $0.title < $1.title }
        case .author:
            articles = articles.sorted { $0.authors < $1.authors }
        case .date:
            articles = articles.sorted {
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "MM/dd/yyyy"
                guard let date1 = dateFormatter.date(from: $0.date),
                        let date2 = dateFormatter.date(from: $1.date) else { return false }
                return date1 > date2
            }
        }
        onArticlesLoaded()
    }
}
