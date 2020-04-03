//
//  Tag+CoreDataClass.swift
//  frederico-murakawa-ios
//
//  Created by Frederico Murakawa on 4/3/20.
//  Copyright © 2020 Frederico Murakawa. All rights reserved.
//
//

import Foundation
import CoreData

@objc(Tag)
public class Tag: NSManagedObject, Decodable {
    enum CodingKeys: String, CodingKey {
        case id, label
    }

    required convenience public init(from decoder: Decoder) throws {
        // return the context from the decoder userinfo dictionary
        guard let contextUserInfoKey = CodingUserInfoKey.context,
            let managedObjectContext = decoder.userInfo[contextUserInfoKey] as? NSManagedObjectContext,
            let entity = NSEntityDescription.entity(forEntityName: "Tag", in: managedObjectContext)
            else {
                fatalError("decode failure")
        }

        // Super init of the NSManagedObject
        self.init(entity: entity, insertInto: managedObjectContext)

        let container = try decoder.container(keyedBy: CodingKeys.self)
        do {
            id = try container.decode(Int16.self, forKey: .id)
            label = try container.decode(String.self, forKey: .label)
        } catch {
            print (error.localizedDescription)
        }
    }
}
