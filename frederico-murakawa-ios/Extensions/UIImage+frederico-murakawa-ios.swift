//
//  UIImage+frederico-murakawa-ios.swift
//  frederico-murakawa-ios
//
//  Created by Frederico Murakawa on 3/29/20.
//  Copyright © 2020 Frederico Murakawa. All rights reserved.
//

import UIKit

extension UIImage {
    static func placeholderImage() -> UIImage? {
        return UIImage(systemName: "photo.on.rectangle")?.withTintColor(.black, renderingMode: .alwaysOriginal)
    }
}
