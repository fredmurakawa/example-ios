//
//  NewsFeedCellViewModel.swift
//  frederico-murakawa-ios
//
//  Created by Frederico Murakawa on 3/28/20.
//  Copyright © 2020 Frederico Murakawa. All rights reserved.
//

import Foundation

class NewsFeedCellViewModel {
    let article: Article

    var onMarkAsReadOrUnread: () -> Void = {}

    var title: String { article.title ?? "" }
    var authors: String { article.authors ?? "" }
    var date: String { article.date ?? "" }
    var imageURL: String { article.imageURL ?? "" }
    var read: Bool { article.read }
    var contextualActionImage: String {
        return read ? "envelope.fill" : "envelope.open.fill"
    }
    var contextualActionTitle: String {
        return read ? "Mark as Unread" : "Mark as Read"
    }

    init(article: Article) {
        self.article = article
    }

    func markArticleAsReadOrUnread() {
        article.read = !article.read
        onMarkAsReadOrUnread()
    }
}
