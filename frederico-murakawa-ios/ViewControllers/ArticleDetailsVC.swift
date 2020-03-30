//
//  ArticleDetailsVC.swift
//  frederico-murakawa-ios
//
//  Created by Frederico Murakawa on 3/30/20.
//  Copyright © 2020 Frederico Murakawa. All rights reserved.
//

import UIKit

class ArticleDetailsVC: UIViewController {
    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var authorsLabel: UILabel!
    @IBOutlet private weak var websiteLabel: UILabel!
    @IBOutlet private weak var tagsLabel: UILabel!
    @IBOutlet private weak var markAsReadButton: UIButton!
    @IBOutlet private weak var dateLabel: UILabel!
    @IBOutlet private weak var contentTextView: UITextView!

    let viewModel: ArticleDetailsViewModel

    init(viewModel: ArticleDetailsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        imageView?.loadImage(at: URL(string: viewModel.imageURL))
        titleLabel.text = viewModel.title
        authorsLabel.text = viewModel.authors
        websiteLabel.text = viewModel.authors
        dateLabel.text = viewModel.date
        contentTextView.text = viewModel.content
        tagsLabel.text = viewModel.tagsLabel()
        markAsReadButton.setTitle(viewModel.contextualActionTitle, for: .normal)
        markAsReadButton.setImage(UIImage(systemName: viewModel.contextualActionImage), for: .normal)
    }

}