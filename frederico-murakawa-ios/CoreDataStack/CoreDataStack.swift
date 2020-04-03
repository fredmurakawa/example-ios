//
//  CoreDataStack.swift
//  frederico-murakawa-ios
//
//  Created by Frederico Murakawa on 4/3/20.
//  Copyright © 2020 Frederico Murakawa. All rights reserved.
//

import Foundation
import CoreData

class CoreDataStack {
    private let modelName: String

    init(modelName: String) {
        self.modelName = modelName
    }

    private lazy var storeContainer: NSPersistentContainer = {

        let container = NSPersistentContainer(name: self.modelName)
        container.loadPersistentStores { (storeDescription, error) in
            if let error = error as NSError? {
                print("Unresolved error \(error), \(error.userInfo)")
            }
        }
        return container
    }()

    lazy var managedContext: NSManagedObjectContext = {
        return self.storeContainer.viewContext
    }()

    func saveContext () {
        guard managedContext.hasChanges else { return }

        do {
            try managedContext.save()
        } catch let error as NSError {
            print("Unresolved error \(error), \(error.userInfo)")
        }
    }

    func fetchArticles(_ completion: @escaping (Result<[Article], Error>) -> Void) {
        let articleFetch: NSFetchRequest<Article> = Article.fetchRequest()
        do {
            let results = try managedContext.fetch(articleFetch)
            completion(.success(results))
        } catch {
            completion(.failure(error))
        }
    }
}
