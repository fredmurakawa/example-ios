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

    var title: String { article.title }
    var website: String { article.website }
    var authors: String { article.authors }
    var date: String { article.date }
    var tags: [Tag] { article.tags }
    var content: String { article.content }
    var imageURL: String { article.imageURL }
    var read: Bool { article.read }
    var contextualActionImage: String {
        return read ? "envelope.fill" : "envelope.open.fill"
    }
    var contextualActionTitle: String {
        return read ? "Unread" : "Read"
    }

    init(article: Article) {
        self.article = article
    }

    func markArticleAsReadOrUnread() {
        article.read = !article.read
    }
}
