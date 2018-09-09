//
//  SearchResultsViewController.swift
//  Food2Fork
//
//  Created by Vadym Markov on 07/09/2018.
//  Copyright © 2018 FINN.no AS. All rights reserved.
//

import UIKit

protocol SearchViewControllerDelegate: AnyObject {
    func searchViewController(_ viewController: SearchViewController, didSelectRecipe recipe: Recipe)
}

final class SearchViewController: UIViewController {
    weak var delegate: SearchViewControllerDelegate?
    private let controllerFactory: ControllerFactory
    private let logicController: SearchLogicController
    private var recipes = [Recipe]()

    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = R.color.milk()
        tableView.tableFooterView = UIView(frame: .zero)
        tableView.estimatedRowHeight = 80
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.register(type: UITableViewCell.self)
        tableView.dataSource = self
        tableView.delegate = self
        return tableView
    }()

    // MARK: - Init

    init(controllerFactory: ControllerFactory, logicController: SearchLogicController) {
        self.controllerFactory = controllerFactory
        self.logicController = logicController
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = R.color.seashell()

        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = R.string.localizable.searchPlaceholder()

        navigationItem.title = R.string.localizable.search()
        navigationItem.searchController = searchController
        definesPresentationContext = true

        view.addSubview(tableView)
        NSLayoutConstraint.pin(tableView, toView: view)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        if #available(iOS 11.0, *) {
            navigationItem.hidesSearchBarWhenScrolling = false
        }

        render(.loading)
    }

    // MARK: - Content

    private func search() {
        let text = navigationItem.searchController?.searchBar.text ?? ""

        guard text.count > 2 else {
            return
        }

        logicController.search(text: text, sort: .trendingness, then: { [weak self] state in
            self?.render(state)
        })
    }

    private func render(_ state: ViewState<[Recipe]>) {
        removeAllChildControllers()

        switch state {
        case .loading:
            add(childController: makeInfoViewController())
        case .presenting(let recipes):
            self.recipes = recipes
            tableView.reloadData()
        case .failed(let error):
            add(childController: makeErrorViewController(with: error))
        }
    }

    // MARK: - Actions

    @objc private func handleSearchButtonTap() {
        navigationItem.searchController?.searchBar.becomeFirstResponder()
    }

    @objc private func handleRetryButtonTap() {
        search()
    }
}

// MARK: - Factory

private extension SearchViewController {
    func makeInfoViewController() -> UIViewController {
        let viewController = controllerFactory.makeInfoViewController()
        viewController.imageView.image = R.image.iconInfoSearch()?.withRenderingMode(.alwaysTemplate)
        viewController.titleLabel.text = R.string.localizable.searchInfoTitle()
        viewController.textLabel.text = R.string.localizable.searchInfoText()
        viewController.button.setTitle(R.string.localizable.search(), for: .normal)
        viewController.button.addTarget(self, action: #selector(handleSearchButtonTap), for: .touchUpInside)
        return viewController
    }

    func makeErrorViewController(with error: Error) -> UIViewController {
        let viewController = controllerFactory.makeErrorViewController(with: error)
        viewController.button.addTarget(self, action: #selector(handleRetryButtonTap), for: .touchUpInside)
        return viewController
    }
}

// MARK: - UITableViewDataSource

extension SearchViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recipes.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeue(type: UITableViewCell.self, indexPath: indexPath)
        let recipe = recipes[indexPath.row]
        cell.textLabel?.font = .body
        cell.textLabel?.textColor = R.color.oil()
        cell.textLabel?.text = recipe.title
        return cell
    }
}

// MARK: - UITableViewDelegate

extension SearchViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let recipe = recipes[indexPath.row]
        delegate?.searchViewController(self, didSelectRecipe: recipe)
    }
}

// MARK: - UISearchResultsUpdating

extension SearchViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        search()
    }
}
