//
//  ViewController.swift
//  frederico-murakawa-ios
//
//  Created by Frederico Murakawa on 3/27/20.
//  Copyright © 2020 Frederico Murakawa. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .red
        navigationItem.leftItemsSupplementBackButton = true
        navigationItem.leftBarButtonItem = splitViewController?.displayModeButtonItem

        let imageView = UIImageView(frame: CGRect(x: 300, y: 100, width: 100, height: 100))
        view.addSubview(imageView)

        imageView.loadImage(at: URL(string: "http://res.cloudinary.com/cheesecakelabs/image/upload/v1488993901/challenge/news_02_ulyqvw.jpg")!)
    }
}

extension ViewController: NewsFeedVCDelegate {
    func didSelectArticle(_ article: Article) {
        print(article)
    }
}
