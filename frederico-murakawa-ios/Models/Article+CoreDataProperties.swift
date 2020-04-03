//
//  Article+CoreDataProperties.swift
//  frederico-murakawa-ios
//
//  Created by Frederico Murakawa on 4/3/20.
//  Copyright © 2020 Frederico Murakawa. All rights reserved.
//
//

import Foundation
import CoreData


extension Article {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Article> {
        return NSFetchRequest<Article>(entityName: "Article")
    }

    @NSManaged public var title: String?
    @NSManaged public var website: String?
    @NSManaged public var authors: String?
    @NSManaged public var date: String?
    @NSManaged public var content: String?
    @NSManaged public var imageURL: String?
    @NSManaged public var read: Bool
    @NSManaged public var tags: NSSet?

}

// MARK: Generated accessors for tags
extension Article {

    @objc(addTagsObject:)
    @NSManaged public func addToTags(_ value: Tag)

    @objc(removeTagsObject:)
    @NSManaged public func removeFromTags(_ value: Tag)

    @objc(addTags:)
    @NSManaged public func addToTags(_ values: NSSet)

    @objc(removeTags:)
    @NSManaged public func removeFromTags(_ values: NSSet)

}
