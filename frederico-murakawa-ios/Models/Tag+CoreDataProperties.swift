//
//  Tag+CoreDataProperties.swift
//  frederico-murakawa-ios
//
//  Created by Frederico Murakawa on 4/3/20.
//  Copyright © 2020 Frederico Murakawa. All rights reserved.
//
//

import Foundation
import CoreData


extension Tag {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Tag> {
        return NSFetchRequest<Tag>(entityName: "Tag")
    }

    @NSManaged public var id: Int16
    @NSManaged public var label: String?
    @NSManaged public var articles: NSSet?

}

// MARK: Generated accessors for articles
extension Tag {

    @objc(addArticlesObject:)
    @NSManaged public func addToArticles(_ value: Article)

    @objc(removeArticlesObject:)
    @NSManaged public func removeFromArticles(_ value: Article)

    @objc(addArticles:)
    @NSManaged public func addToArticles(_ values: NSSet)

    @objc(removeArticles:)
    @NSManaged public func removeFromArticles(_ values: NSSet)

}
