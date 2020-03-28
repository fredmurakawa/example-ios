//
//  NewsFeedVCTableViewController.swift
//  frederico-murakawa-ios
//
//  Created by Frederico Murakawa on 3/28/20.
//  Copyright © 2020 Frederico Murakawa. All rights reserved.
//

import UIKit

protocol NewsFeedVCDelegate: class {
    func didSelectArticle(_ article: Article)
}

class NewsFeedVC: UITableViewController {

    weak var delegate: NewsFeedVCDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "News"
        
        let nib = UINib(nibName: "NewsFeedCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: NewsFeedCell.reuseIdentifier)
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: NewsFeedCell.reuseIdentifier, for: indexPath) as? NewsFeedCell else {
            preconditionFailure("Incorrect cell setup for table view")
        }
        return cell
    }

    // MARK: - Table view delegate

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.didSelectArticle(Article(title: "a", website: "b", authors: "c", date: "d", content: "e", tags: [], imageURL: "f"))
        if let detailViewController = delegate as? ViewController, let detailNavigationController = detailViewController.navigationController {
          splitViewController?.showDetailViewController(detailNavigationController, sender: nil)
        }
    }
}
