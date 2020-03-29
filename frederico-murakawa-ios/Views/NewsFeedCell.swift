//
//  NewsFeedCell.swift
//  frederico-murakawa-ios
//
//  Created by Frederico Murakawa on 3/28/20.
//  Copyright © 2020 Frederico Murakawa. All rights reserved.
//

import UIKit

class NewsFeedCell: UITableViewCell {
    static let reuseIdentifier = "NewsFeedCell"

    @IBOutlet private weak var articleImageView: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var authorsLabel: UILabel!
    @IBOutlet private weak var dateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()

        articleImageView?.layer.cornerRadius = articleImageView.bounds.width / 2
    }

    override func prepareForReuse() {
        super.prepareForReuse()

        articleImageView?.cancelImageLoad()
        articleImageView?.image = nil
        titleLabel.text = nil
        authorsLabel.text = nil
        dateLabel.text = nil
    }

    func configure(with viewModel: NewsFeedCellViewModel) {
        titleLabel?.text = viewModel.title
        authorsLabel?.text = viewModel.authors
        dateLabel?.text = viewModel.date
        if let url = URL(string: viewModel.imageURL) {
            articleImageView?.loadImage(at: url)
        }
    }
}
