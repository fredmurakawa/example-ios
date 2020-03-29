//
//  NewsFeedCellViewModel.swift
//  frederico-murakawa-ios
//
//  Created by Frederico Murakawa on 3/28/20.
//  Copyright © 2020 Frederico Murakawa. All rights reserved.
//

import Foundation

public class NewsFeedCellViewModel {
    private let article: Article

    var onArticlesLoaded: () -> Void = {}

    init(article: Article) {
        self.article = article
    }

    var title: String { article.title }
    var authors: String { article.authors }
    var date: String { article.date }
    var imageURL: String { article.imageURL }
}
