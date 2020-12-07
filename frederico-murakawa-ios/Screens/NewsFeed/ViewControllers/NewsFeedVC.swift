//
//  NewsFeedVCTableViewController.swift
//  frederico-murakawa-ios
//
//  Created by Frederico Murakawa on 3/28/20.
//  Copyright © 2020 Frederico Murakawa. All rights reserved.
//

import UIKit

final class NewsFeedVC: UITableViewController {
    private let viewModel: NewsFeedViewModelProtocol

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

    init(viewModel: NewsFeedViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setupNavBar()
        setupActivityIndicator()
        setupTableView()

        viewModel.onArticlesLoaded = { [weak self] in
            self?.reloadData()
        }

        viewModel.onLoadFailed = { [weak self] in
            self?.presentLoadFailedAlert()
        }

        loadArticles()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    private func setupNavBar() {
        title = "News"
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Sort", style: .plain, target: self, action: #selector(sortArticles))
    }

    private func setupActivityIndicator() {
        view.addSubview(activityIndicator)
        activityIndicator.centerXAnchor.constraint(equalTo: tableView.centerXAnchor).isActive = true
        activityIndicator.centerYAnchor.constraint(equalTo: tableView.centerYAnchor).isActive = true
    }

    private func setupTableView() {
        tableView.refreshControl = tableRefreshControl
        tableView.tableFooterView = UIView()
        let nib = UINib(nibName: NewsFeedCell.reuseIdentifier, bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: NewsFeedCell.reuseIdentifier)
    }
    
    private func reloadData() {
        DispatchQueue.main.async {
            self.stopRefreshing()
            self.tableView.reloadData()
        }
    }
    
    private func presentLoadFailedAlert() {
        let retryAction = UIAlertAction(title: "Retry", style: .default) { _ in
            self.loadArticles()
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)

        DispatchQueue.main.async {
            self.stopRefreshing()
            self.presentAlert(title: "Oops",
                              message: "Articles could not be loaded.",
                              preferredStyle: .alert,
                              actions: [retryAction, cancelAction])
        }
    }
    
    private func presentAlert(title: String, message: String, preferredStyle: UIAlertController.Style, actions: [UIAlertAction]) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: preferredStyle)
        
        actions.forEach { (action) in
            alertController.addAction(action)
        }
        
        present(alertController, animated: true, completion: nil)
    }

    private func loadArticles() {
        activityIndicator.startAnimating()
        viewModel.loadArticles(sortBy: .date)
    }

    private func stopRefreshing() {
        refreshControl?.endRefreshing()
        activityIndicator.stopAnimating()
    }

    @objc private func sortArticles() {
        let alertController = UIAlertController(title: "Sort by", message: nil, preferredStyle: .actionSheet)
        alertController.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem

        let titleAction = UIAlertAction(title: "Title", style: .default) { _ in
            self.viewModel.updateSortType(to: .title)
        }
        let authorAction = UIAlertAction(title: "Author", style: .default) { _ in
            self.viewModel.updateSortType(to: .author)
        }
        let dateAction = UIAlertAction(title: "Date", style: .default) { _ in
            self.viewModel.updateSortType(to: .date)
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)

        alertController.addAction(titleAction)
        alertController.addAction(authorAction)
        alertController.addAction(dateAction)
        alertController.addAction(cancelAction)
        
        present(alertController, animated: true, completion: nil)
    }

    @objc private func refreshControlTriggered() {
        viewModel.loadArticles(sortBy: .date)
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

    override func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        guard let cell = tableView.cellForRow(at: indexPath) as? NewsFeedCell else {
            preconditionFailure("Incorrect cell for table view")
        }
        let cellViewModel = self.viewModel.cellViewModelForArticle(at: indexPath.row)
        cellViewModel.onMarkAsReadOrUnread = { [weak cell] in
            cell?.configureTitleLabel(with: cellViewModel)
        }
        let action = UIContextualAction(style: .normal, title: cellViewModel.contextualActionTitle) { (action, view, completionHandler) in
            cellViewModel.markArticleAsReadOrUnread()
            completionHandler(true)
        }
        action.image = UIImage(systemName: cellViewModel.contextualActionImage)
        action.backgroundColor = .blue

        let configuration = UISwipeActionsConfiguration(actions: [action])
        configuration.performsFirstActionWithFullSwipe = true
        return configuration
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let article = self.viewModel.getArticle(at: indexPath.row)
        let articleDetailsViewModel = ArticleDetailsViewModel(article: article)
        let detailsVC = UINavigationController(rootViewController: ArticleDetailsVC(viewModel: articleDetailsViewModel))
        splitViewController?.showDetailViewController(detailsVC, sender: nil)
    }
}
