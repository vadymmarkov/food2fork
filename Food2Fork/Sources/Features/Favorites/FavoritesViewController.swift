//
//  FavoritesViewController.swift
//  Food2Fork
//
//  Created by Markov, Vadym on 05/09/2018.
//  Copyright © 2018 FINN.no AS. All rights reserved.
//

import UIKit

import UIKit

final class FavoritesViewController: UIViewController {
    private let viewControllerFactory: UtilityViewControllerFactory
    private let navigator: RecipeNavigator
    private let logicController: FavoritesLogicController
    private let imageLoader: ImageLoader
    private var recipes = [Recipe]()

    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = R.color.milk()
        tableView.tableFooterView = UIView(frame: .zero)
        tableView.separatorStyle = .none
        tableView.register(type: FavoriteTableViewCell.self)
        tableView.dataSource = self
        tableView.delegate = self
        return tableView
    }()

    private lazy var refreshControl = UIRefreshControl()

    // MARK: - Init

    init(viewControllerFactory: UtilityViewControllerFactory,
         navigator: RecipeNavigator,
         logicController: FavoritesLogicController,
         imageLoader: ImageLoader) {
        self.viewControllerFactory = viewControllerFactory
        self.navigator = navigator
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
        navigationItem.title = R.string.localizable.favorites()
        view.backgroundColor = R.color.seashell()
        view.addSubview(tableView)

        tableView.insertSubview(refreshControl, at: 0)
        refreshControl.addTarget(self, action: #selector(loadContent), for: .valueChanged)

        NSLayoutConstraint.pin(tableView, toView: view)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadContent()
    }

    // MARK: - Content

    @objc private func loadContent() {
        logicController.load(then: { [weak self] state in
            self?.render(state)
        })
    }

    private func render(_ state: ViewState<[Recipe]>) {
        removeAllChildViewControllers()

        switch state {
        case .loading:
            if recipes.isEmpty {
                add(childViewController: viewControllerFactory.makeLoadingViewController())
            }
        case .presenting(let recipes):
            self.recipes = recipes
            tableView.reloadData()

            if self.recipes.isEmpty {
                add(childViewController: makeInfoViewController())
            }
        case .failed:
            self.recipes = []
            tableView.reloadData()
            add(childViewController: makeInfoViewController())
        }

        if refreshControl.isRefreshing {
            refreshControl.endRefreshing()
        }
    }

    // MARK: - Actions

    @objc private func handleSearchButtonTap() {
        navigationItem.searchController?.searchBar.becomeFirstResponder()
    }
}

// MARK: - Factory

private extension FavoritesViewController {
    func makeInfoViewController() -> UIViewController {
        let viewController = viewControllerFactory.makeInfoViewController()
        viewController.titleLabel.text = R.string.localizable.favoritesInfoTitle()
        viewController.textLabel.text = R.string.localizable.favoritesInfoText()
        viewController.button.isHidden = true
        return viewController
    }
}

// MARK: - UITableViewDataSource

extension FavoritesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recipes.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeue(type: FavoriteTableViewCell.self, indexPath: indexPath)
        let recipe = recipes[indexPath.row]
        cell.titleLabel.text = recipe.title
        cell.subtitleLabel.text = recipe.publisher
        cell.accessoryLabel.text = "\(Int(recipe.socialRank))"
        imageLoader.loadImage(at: recipe.imageUrl, to: cell.coverImageView)
        return cell
    }
}

// MARK: - UITableViewDelegate

extension FavoritesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let recipe = recipes[indexPath.row]
        navigator.navigate(to: recipe)
    }
}
