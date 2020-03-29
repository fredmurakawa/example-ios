//
//  UIFont+frederico-murakawa-ios.swift
//  frederico-murakawa-ios
//
//  Created by Frederico Murakawa on 3/28/20.
//  Copyright © 2020 Frederico Murakawa. All rights reserved.
//

import UIKit

extension UIFont {
    static func titleFontNotRead() -> UIFont {
        return UIFont.systemFont(ofSize: 16, weight: .semibold)
    }

    static func titleFontRead() -> UIFont {
        return UIFont.systemFont(ofSize: 16, weight: .regular)
    }
}
