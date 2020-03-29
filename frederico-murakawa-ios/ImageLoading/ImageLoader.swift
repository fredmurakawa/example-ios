//
//  ImageLoading.swift
//  frederico-murakawa-ios
//
//  Created by Frederico Murakawa on 3/27/20.
//  Copyright © 2020 Frederico Murakawa. All rights reserved.
//

import UIKit

final class ImageLoader {
    private let cache = Cache<URL, UIImage>()
    private var runningRequests = [UUID: URLSessionDataTask]() // Keep a reference to data task to cancel it later if needed

    func loadImage(_ url: URL, _ completion: @escaping (Result<UIImage, Error>) -> Void) -> UUID? {

        if let image = cache[url] {
            completion(.success(image))
            return nil
        }

        let uuid = UUID()

        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            defer { self.runningRequests.removeValue(forKey: uuid) }

            if let data = data, let image = UIImage(data: data) {
                self.cache[url] = image
                completion(.success(image))
                return
            }

            guard let error = error else {
                // without an image or an error, we'll just ignore this for now
                #warning("Implement this case")
                return
            }

            // Check if the request was cancelled
            guard (error as NSError).code == NSURLErrorCancelled else {
                completion(.failure(error))
                return
            }

            // the request was cancelled, no need to call the callback
        }
        task.resume()

        runningRequests[uuid] = task

        return uuid
    }

    func cancelLoad(_ uuid: UUID) {
        runningRequests[uuid]?.cancel()
        runningRequests.removeValue(forKey: uuid)
    }
}
