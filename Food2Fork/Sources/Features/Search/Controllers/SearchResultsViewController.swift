//
//  SearchResultsViewController.swift
//  Food2Fork
//
//  Created by Vadym Markov on 07/09/2018.
//  Copyright © 2018 FINN.no AS. All rights reserved.
//

import UIKit

protocol SearchResultsViewControllerDelegate: AnyObject {

}

final class SearchResultsViewController: UITableViewController {
    weak var delegate: SearchResultsViewControllerDelegate?
    private let logicController: SearchLogicController
    private let imageLoader: ImageLoader
    private var recipes = [Recipe]()

    // MARK: - Init

    init(logicController: SearchLogicController, imageLoader: ImageLoader) {
        self.logicController = logicController
        self.imageLoader = imageLoader
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = R.color.seashell()
        setupTableView()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        render(.loading)
    }

    // MARK: - Content

    private func render(_ state: SearchState) {
        switch state {
        case .loading:
            break
        case .presenting(let recipes):
            self.recipes = recipes
            tableView.reloadData()
        case .failed(let error):
            break
        }
    }

    private func setupTableView() {
        tableView.backgroundColor = R.color.milk()
        tableView.tableFooterView = UIView(frame: .zero)
        tableView.estimatedRowHeight = 64
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.register(type: UITableViewCell.self)
    }

    // MARK: - UITableViewDataSource

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recipes.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeue(type: UITableViewCell.self, indexPath: indexPath)
        let recipe = recipes[indexPath.row]
        imageLoader.loadImage(at: recipe.imageUrl, to: cell.imageView!)
        cell.textLabel?.text = recipe.title
        cell.detailTextLabel?.text = recipe.publisher
        return cell
    }

    // MARK: - UITableViewDelegate

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }
}

// MARK: - UISearchResultsUpdating

extension SearchResultsViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        let text = searchController.searchBar.text ?? ""

        guard text.count > 2 else {
            return
        }

        logicController.search(text: text, sort: .trendingness, then: { [weak self] state in
            self?.render(state)
        })
    }
}
