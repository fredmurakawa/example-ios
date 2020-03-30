//
//  ImageViewLoader.swift
//  frederico-murakawa-ios
//
//  Created by Frederico Murakawa on 3/27/20.
//  Copyright © 2020 Frederico Murakawa. All rights reserved.
//

import UIKit

final class ImageViewLoader {
    static let loader = ImageViewLoader()
    private let imageLoader = ImageLoader()
    private var uuidMap = [UIImageView: UUID]() // Tie Image View with UUID to cancel loading tasks later if needed

    private init() {}

    fileprivate func load(_ url: URL, for imageView: UIImageView) {
        let uuid = imageLoader.loadImage(url) { result in
            defer { self.uuidMap.removeValue(forKey: imageView) }

            do {
                let image = try result.get()
                DispatchQueue.main.async {
                    imageView.image = image
                }
            } catch {
                print("Failed to fetch image at: \(url.absoluteString)", error)
                DispatchQueue.main.async {
                    imageView.image = UIImage.placeholderImage()
                }
            }
        }

        if let uuid = uuid {
            uuidMap[imageView] = uuid
        }
    }

    fileprivate func cancel(for imageView: UIImageView) {
        if let uuid = uuidMap[imageView] {
            imageLoader.cancelLoad(uuid)
            uuidMap.removeValue(forKey: imageView)
        }
    }
}

extension UIImageView {
    public func loadImage(at url: URL?) {
        guard let url = url else {
            self.image = UIImage.placeholderImage()?.withTintColor(.black, renderingMode: .alwaysOriginal)
            return
        }
        ImageViewLoader.loader.load(url, for: self)
    }

    public func cancelImageLoad() {
        ImageViewLoader.loader.cancel(for: self)
    }
}

