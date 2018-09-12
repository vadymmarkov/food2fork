//
//  SearchResultsViewController.swift
//  Food2Fork
//
//  Created by Vadym Markov on 07/09/2018.
//  Copyright © 2018 FINN.no AS. All rights reserved.
//

import UIKit

final class SearchViewController: UIViewController {
    private let viewControllerFactory: UtilityViewControllerFactory
    private let navigator: RecipeNavigator
    private let logicController: SearchLogicController
    private let paginator = Paginator()
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

    init(viewControllerFactory: UtilityViewControllerFactory,
         navigator: RecipeNavigator,
         logicController: SearchLogicController) {
        self.viewControllerFactory = viewControllerFactory
        self.navigator = navigator
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
        searchController.searchBar.delegate = self
        searchController.searchBar.placeholder = R.string.localizable.searchPlaceholder()

        navigationItem.title = R.string.localizable.search()
        navigationItem.searchController = searchController
        definesPresentationContext = true

        view.addSubview(tableView)
        NSLayoutConstraint.pin(tableView, toView: view)

        render(.loading)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        if #available(iOS 11.0, *) {
            navigationItem.hidesSearchBarWhenScrolling = false
        }
    }

    // MARK: - Content

    @objc private func search() {
        paginator.reset()
        loadContent()
    }

    private func loadContent() {
        let text = navigationItem.searchController?.searchBar.text ?? ""

        guard text.count > 2 else {
            return
        }

        paginator.isLocked = true
        logicController.search(text: text, page: paginator.page, then: { [weak self] state in
            self?.render(state)
            self?.paginator.isLocked = false
        })
    }

    private func render(_ state: ViewState<[Recipe]>) {
        removeAllChildViewControllers()

        switch state {
        case .loading:
            add(childViewController: makeInfoViewController())
        case .presenting(let recipes):
            if paginator.page == 1 {
                self.recipes = recipes
            } else {
                self.recipes.append(contentsOf: recipes)
            }
            paginator.isLastPage = recipes.isEmpty
            tableView.reloadData()
        case .failed(let error):
            self.recipes = []
            tableView.reloadData()
            add(childViewController: makeErrorViewController(with: error))
        }
    }

    // MARK: - Actions

    @objc private func handleSearchButtonTap() {
        navigationItem.searchController?.searchBar.becomeFirstResponder()
    }
}

// MARK: - Factory

private extension SearchViewController {
    func makeInfoViewController() -> UIViewController {
        let viewController = viewControllerFactory.makeInfoViewController()
        viewController.imageView.image = R.image.iconInfoSearch()?.withRenderingMode(.alwaysTemplate)
        viewController.titleLabel.text = R.string.localizable.searchInfoTitle()
        viewController.textLabel.text = R.string.localizable.searchInfoText()
        viewController.button.setTitle(R.string.localizable.search(), for: .normal)
        viewController.button.addTarget(self, action: #selector(handleSearchButtonTap), for: .touchUpInside)
        return viewController
    }

    func makeErrorViewController(with error: Error) -> UIViewController {
        let viewController = viewControllerFactory.makeInfoViewController(with: error)
        viewController.button.addTarget(self, action: #selector(search), for: .touchUpInside)
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
        tableView.deselectRow(at: indexPath, animated: false)
        navigator.navigate(to: recipe)
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard paginator.shouldPaginate(scrollView: scrollView) else {
            return
        }
        paginator.next()
        loadContent()
    }
}

// MARK: - UISearchResultsUpdating

extension SearchViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard searchController.searchBar.text?.isEmpty == false else {
            render(.loading)
            return
        }
        search()
    }
}

// MARK: - UISearchBarDelegate

extension SearchViewController: UISearchBarDelegate {
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        render(.loading)
    }
}
