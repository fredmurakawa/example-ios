//
//  ArticleDetailsViewModel.swift
//  frederico-murakawa-ios
//
//  Created by Frederico Murakawa on 3/30/20.
//  Copyright © 2020 Frederico Murakawa. All rights reserved.
//

import Foundation

class ArticleDetailsViewModel: NewsFeedCellViewModel {
    var website: String { self.article.website }
    var content: String { article.content }

    func tagsLabel() -> String {
        var label = "Tags:"
        for (index, tag) in article.tags.enumerated() {
            if index > 0 {
                label += ","
            }
            label += " \(tag.label)"
        }
        return label
    }
}
