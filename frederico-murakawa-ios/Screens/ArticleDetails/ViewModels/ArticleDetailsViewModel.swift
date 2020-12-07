//
//  ArticleDetailsViewModel.swift
//  frederico-murakawa-ios
//
//  Created by Frederico Murakawa on 3/30/20.
//  Copyright © 2020 Frederico Murakawa. All rights reserved.
//

import Foundation

protocol ArticleDetailsViewModelProtocol: NewsFeedCellViewModelProtocol {
    var website: String { get }
    var content: String { get }
    
    func tagsLabel() -> String
}

class ArticleDetailsViewModel: NewsFeedCellViewModel, ArticleDetailsViewModelProtocol {
    var website: String { "Website: \(self.article.website ?? "")" }
    var content: String { article.content ?? "" }

    func tagsLabel() -> String {
        guard let tags = article.tags else { return "" }
        var label = "Tags:"
        for (index, tag) in tags.enumerated() {
            guard let tag = tag as? Tag else { continue }
            if index > 0 {
                label += ","
            }
            label += " \(tag.label ?? "")"
        }
        return label
    }
}
