//
//  APISession.swift
//  frederico-murakawa-ios
//
//  Created by Frederico Murakawa on 3/27/20.
//  Copyright © 2020 Frederico Murakawa. All rights reserved.
//

import Foundation

protocol RequestProviding {
    var urlRequest: URLRequest { get }
}

protocol APISessionProviding {
    func fetch<T: Decodable>(coreDataStack: CoreDataStack, _ requestProvider: RequestProviding, completion: @escaping (Result<T, Error>) -> Void)
}

struct APISession: APISessionProviding {
    init() {}

    func fetch<T: Decodable>(coreDataStack: CoreDataStack, _ requestProvider: RequestProviding, completion: @escaping (Result<T, Error>) -> Void) {
        let urlRequest = requestProvider.urlRequest

        URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            do {
                if let error = error {
                    completion(.failure(error))
                    return
                }

                guard let data = data else {
                    preconditionFailure("No error was received but we also don't have data.")
                }

                let decoder = JSONDecoder()
                decoder.userInfo[CodingUserInfoKey.context!] = coreDataStack.managedContext
                let decodedObject = try decoder.decode(T.self, from: data)

                coreDataStack.saveContext()

                completion(.success(decodedObject))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
}
