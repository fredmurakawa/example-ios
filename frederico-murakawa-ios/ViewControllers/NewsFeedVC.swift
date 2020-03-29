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
    private let viewModel: NewsFeedViewModel

    private lazy var activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        return activityIndicator
    }()

    private lazy var tableRefreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refreshControlTriggered), for: .valueChanged)
        return refreshControl
    }()

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
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Sort", style: .plain, target: self, action: #selector(sortArticles))

        setupActivityIndicator()
        setupTableView()

        viewModel.onArticlesLoaded = { [weak self] in
            DispatchQueue.main.async {
                self?.refreshControl?.endRefreshing()
                self?.activityIndicator.stopAnimating()
                self?.tableView.reloadData()
            }
        }

        viewModel.loadArticles()
    }

    private func setupActivityIndicator() {
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.startAnimating()
        view.addSubview(activityIndicator)
        activityIndicator.centerXAnchor.constraint(equalTo: tableView.centerXAnchor).isActive = true
        activityIndicator.centerYAnchor.constraint(equalTo: tableView.centerYAnchor).isActive = true
    }

    private func setupTableView() {
        tableView.refreshControl = tableRefreshControl
        tableView.tableFooterView = UIView()
        let nib = UINib(nibName: "NewsFeedCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: NewsFeedCell.reuseIdentifier)
    }

    @objc private func sortArticles() {
        let alertController = UIAlertController(title: "Sort by", message: nil, preferredStyle: .actionSheet)
        let titleAction = UIAlertAction(title: "Title", style: .default) { _ in
            self.viewModel.sortArticles(by: .title)
        }
        let authorAction = UIAlertAction(title: "Author", style: .default) { _ in
            self.viewModel.sortArticles(by: .author)
        }
        let dateAction = UIAlertAction(title: "Date", style: .default) { _ in
            self.viewModel.sortArticles(by: .date)
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)

        alertController.addAction(titleAction)
        alertController.addAction(authorAction)
        alertController.addAction(dateAction)
        alertController.addAction(cancelAction)
        
        present(alertController, animated: true, completion: nil)
    }

    @objc private func refreshControlTriggered() {
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
    }
}
