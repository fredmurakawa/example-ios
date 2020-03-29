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
    let viewModel: NewsFeedViewModel

    weak var delegate: NewsFeedVCDelegate?

    init(viewModel: NewsFeedViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "News"
        
        tableView.tableFooterView = UIView()
        let nib = UINib(nibName: "NewsFeedCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: NewsFeedCell.reuseIdentifier)

        viewModel.onArticlesLoaded = { [weak self] in
            DispatchQueue.main.async {
              self?.tableView.reloadData()
            }
        }

        viewModel.loadArticles()
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRowsInSection
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: NewsFeedCell.reuseIdentifier, for: indexPath) as? NewsFeedCell else {
            preconditionFailure("Incorrect cell setup for table view")
        }

        let cellViewModel = viewModel.cellViewModelForArticle(at: indexPath.row)
        cell.configure(with: cellViewModel)
        return cell
    }

    // MARK: - Table view delegate

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cellViewModel = viewModel.cellViewModelForArticle(at: indexPath.row)
        cellViewModel.markArticleAsReadOrUnread()
        tableView.reloadRows(at: [indexPath], with: .automatic)
        
        if let detailViewController = delegate as? ViewController, let detailNavigationController = detailViewController.navigationController {
          splitViewController?.showDetailViewController(detailNavigationController, sender: nil)
        }
    }
}
