//
//  Article+CoreDataClass.swift
//  frederico-murakawa-ios
//
//  Created by Frederico Murakawa on 4/3/20.
//  Copyright © 2020 Frederico Murakawa. All rights reserved.
//
//

import Foundation
import CoreData

@objc(Article)
public class Article: NSManagedObject, Decodable {
    enum CodingKeys: String, CodingKey {
        case title, website, authors, date, content, tags
        case imageURL = "image_url"
    }

    required convenience public init(from decoder: Decoder) throws {
        // return the context from the decoder userinfo dictionary
        guard let contextUserInfoKey = CodingUserInfoKey.context,
            let managedObjectContext = decoder.userInfo[contextUserInfoKey] as? NSManagedObjectContext,
            let entity = NSEntityDescription.entity(forEntityName: "Article", in: managedObjectContext)
            else {
                fatalError("decode failure")
            }

        self.init(entity: entity, insertInto: managedObjectContext)

        let container = try decoder.container(keyedBy: CodingKeys.self)
        do {
            title = try container.decodeIfPresent(String.self, forKey: .title)
            authors = try container.decodeIfPresent(String.self, forKey: .authors)
            website = try container.decodeIfPresent(String.self, forKey: .website)
            date = try container.decodeIfPresent(String.self, forKey: .date)
            content = try container.decodeIfPresent(String.self, forKey: .content)
            imageURL = try container.decodeIfPresent(String.self, forKey: .imageURL)
            title = try container.decodeIfPresent(String.self, forKey: .title)
            tags = NSSet(array: try container.decodeIfPresent([Tag].self, forKey: .tags) ?? [])
        } catch {
            print(error.localizedDescription)
        }
    }
}
