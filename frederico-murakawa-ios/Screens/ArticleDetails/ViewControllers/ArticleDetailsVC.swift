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

    let viewModel: ArticleDetailsViewModelProtocol

    init(viewModel: ArticleDetailsViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setupNavBar()
        setupViews()
        configureMarkAsReadButton()

        viewModel.onMarkAsReadOrUnread = { [weak self] in
            self?.configureMarkAsReadButton()
        }
    }
    
    private func setupNavBar() {
        title = "Article"
        navigationItem.leftItemsSupplementBackButton = true
        navigationItem.leftBarButtonItem = splitViewController?.displayModeButtonItem
    }
    
    private func setupViews() {
        imageView.layer.borderWidth = 2
        imageView.layer.borderColor = UIColor.lightGray.cgColor
        imageView?.loadImage(at: URL(string: viewModel.imageURL))
        titleLabel.text = viewModel.title
        authorsLabel.text = viewModel.authors
        websiteLabel.text = viewModel.website
        dateLabel.text = viewModel.date
        contentTextView.text = viewModel.content
        tagsLabel.text = viewModel.tagsLabel()
        markAsReadButton.addTarget(self, action: #selector(markAsReadTapped), for: .touchUpInside)
    }

    private func configureMarkAsReadButton() {
        markAsReadButton.setImage(UIImage(systemName: viewModel.contextualActionImage), for: .normal)
        markAsReadButton.setTitle("\(viewModel.contextualActionTitle) ", for: .normal)
        
        //Invert button title and image positions
        markAsReadButton.transform = CGAffineTransform(scaleX: -1.0, y: 1.0)
        markAsReadButton.titleLabel?.transform = CGAffineTransform(scaleX: -1.0, y: 1.0)
        markAsReadButton.imageView?.transform = CGAffineTransform(scaleX: -1.0, y: 1.0)
    }

    @objc private func markAsReadTapped() {
        viewModel.markArticleAsReadOrUnread()
    }
}
