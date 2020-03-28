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

    @IBOutlet weak var articleImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var authorsLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()

        articleImageView.layer.cornerRadius = articleImageView.bounds.width / 2
    }

    override func prepareForReuse() {
        super.prepareForReuse()

        articleImageView.cancelImageLoad()
        articleImageView.image = nil
    }
}
