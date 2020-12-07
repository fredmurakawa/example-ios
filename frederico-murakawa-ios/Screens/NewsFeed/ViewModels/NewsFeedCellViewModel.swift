//
//  NewsFeedCellViewModel.swift
//  frederico-murakawa-ios
//
//  Created by Frederico Murakawa on 3/28/20.
//  Copyright © 2020 Frederico Murakawa. All rights reserved.
//

import Foundation

protocol NewsFeedCellViewModelProtocol: AnyObject {
    var article: Article { get }
    var title: String { get }
    var authors: String { get }
    var date: String { get }
    var imageURL: String { get }
    var read: Bool { get }
    var contextualActionImage: String { get }
    var contextualActionTitle: String { get }
    var onMarkAsReadOrUnread: () -> Void { get set }
    
    func markArticleAsReadOrUnread()
}

class NewsFeedCellViewModel: NewsFeedCellViewModelProtocol {
    private let coreDataStack: CoreDataStack?
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

    init(article: Article, coreDataStack: CoreDataStack? = nil) {
        self.article = article
        self.coreDataStack = coreDataStack
    }

    func markArticleAsReadOrUnread() {
        article.read = !article.read
        coreDataStack?.saveContext()
        onMarkAsReadOrUnread()
    }
}
