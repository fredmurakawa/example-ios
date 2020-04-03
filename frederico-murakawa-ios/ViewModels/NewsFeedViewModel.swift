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
    private let coreDataStack: CoreDataStack
    private var sortType = SortType.date {
        didSet {
            sortArticles()
        }
    }

    var onArticlesLoaded: () -> Void = {}
    var onLoadFailed: () -> Void = {}

    var numberOfRowsInSection: Int { articles.count }

    init(articlesProvider: ArticlesProviding, coreDataStack: CoreDataStack) {
        self.articlesProvider = articlesProvider
        self.coreDataStack = coreDataStack
    }

    func updateSortType(to sortType: SortType) {
        self.sortType = sortType
    }

    func loadArticles(sortBy: SortType = .date) {
        coreDataStack.fetchArticles { [weak self] (result) in
            guard let self = self else { return }
            switch result {
            case .success(let fetchedArticles):
                if !fetchedArticles.isEmpty {
                    self.articles = fetchedArticles
                    self.sortArticles()
                    self.onArticlesLoaded()
                    return
                } else {
                    self.articlesProvider.getArticles(coreDataStack: self.coreDataStack) { [weak self] result in
                          guard let self = self else { return }
                          do {
                              self.articles = try result.get()
                              self.sortArticles()
                              self.onArticlesLoaded()
                          } catch {
                              print(error.localizedDescription)
                              self.onLoadFailed()
                          }
                      }
                }
            case.failure(let error):
                print(error.localizedDescription)
                self.onLoadFailed()
            }
        }
    }

    func getArticle(at index: Int) -> Article {
        return articles[index]
    }

    func cellViewModelForArticle(at index: Int) -> NewsFeedCellViewModel {
        let article = articles[index]
        return NewsFeedCellViewModel(article: article, coreDataStack: coreDataStack)
    }

    private func sortArticles() {
        switch sortType {
        case .title:
            articles = articles.sorted {
                guard let title0 = $0.title, let title1 = $1.title else { return false }
                return title0 < title1
            }
        case .author:
            articles = articles.sorted {
                guard let authors0 = $0.authors, let authors1 = $1.authors else { return false }
                return authors0 < authors1
            }
        case .date:
            articles = articles.sorted {
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "MM/dd/yyyy"
                guard let d0 = $0.date, let date0 = dateFormatter.date(from: d0),
                        let d1 = $1.date, let date1 = dateFormatter.date(from: d1) else { return false }
                return date0 > date1
            }
        }
        onArticlesLoaded()
    }
}
