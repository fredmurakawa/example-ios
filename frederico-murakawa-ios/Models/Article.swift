//
//  Article.swift
//  frederico-murakawa-ios
//
//  Created by Frederico Murakawa on 3/27/20.
//  Copyright © 2020 Frederico Murakawa. All rights reserved.
//

import Foundation

// MARK: - Article
struct Article: Decodable {
    let title: String
    let website: String
    let authors: String
    let date: String
    let content: String
    let tags: [Tag]
    let imageURL: String

    enum CodingKeys: String, CodingKey {
        case title, website, authors, date, content, tags
        case imageURL = "image_url"
    }
}

// MARK: - Tag
struct Tag: Decodable {
    let id: Int
    let label: String
}
