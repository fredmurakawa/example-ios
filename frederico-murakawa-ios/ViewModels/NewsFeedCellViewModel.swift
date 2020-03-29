//
//  NewsFeedCellViewModel.swift
//  frederico-murakawa-ios
//
//  Created by Frederico Murakawa on 3/28/20.
//  Copyright © 2020 Frederico Murakawa. All rights reserved.
//

import Foundation

struct NewsFeedCellViewModel {
    private let article: Article

    var onArticlesLoaded: () -> Void = {}

    var title: String { article.title }
    var authors: String { article.authors }
    var date: String { article.date }
    var imageURL: String { article.imageURL }
    var read: Bool { article.read }
    var actionImage: String {
        return read ? "envelope.fill" : "envelope.open.fill"
    }

    init(article: Article) {
        self.article = article
    }

    func markArticleAsReadOrUnread() {
        article.read = !article.read
    }
}
