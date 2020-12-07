//
//  NewsFeedCell.swift
//  frederico-murakawa-ios
//
//  Created by Frederico Murakawa on 3/28/20.
//  Copyright © 2020 Frederico Murakawa. All rights reserved.
//

import UIKit

final class NewsFeedCell: UITableViewCell {
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

    func configure(with viewModel: NewsFeedCellViewModelProtocol) {
        titleLabel?.text = viewModel.title
        configureTitleLabel(with: viewModel)
        authorsLabel?.text = viewModel.authors
        dateLabel?.text = viewModel.date
        articleImageView?.loadImage(at: URL(string: viewModel.imageURL))
    }

    func configureTitleLabel(with viewModel: NewsFeedCellViewModelProtocol) {
        if viewModel.read {
            titleLabel.font = UIFont.titleFontRead()
            titleLabel.textColor = UIColor.lightGray()
        } else {
            titleLabel.font = UIFont.titleFontNotRead()
            titleLabel.textColor = .label
        }
    }
}
