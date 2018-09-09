//
//  FavoritesViewController.swift
//  Food2Fork
//
//  Created by Markov, Vadym on 05/09/2018.
//  Copyright © 2018 FINN.no AS. All rights reserved.
//

import UIKit

import UIKit

protocol FavoritesViewControllerDelegate: AnyObject {
    func favoritesViewController(_ viewController: FavoritesViewController, didSelectRecipe recipe: Recipe)
}

final class FavoritesViewController: UIViewController {
    weak var delegate: FavoritesViewControllerDelegate?
    private let controllerFactory: ControllerFactory
    private let logicController: FavoritesLogicController
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

    init(controllerFactory: ControllerFactory, logicController: FavoritesLogicController) {
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
        navigationItem.title = R.string.localizable.favorites()
        view.addSubview(tableView)
        NSLayoutConstraint.pin(tableView, toView: view)
    }

    // MARK: - Content

    private func render(_ state: ViewState<[Recipe]>) {
        removeAllChildControllers()

        switch state {
        case .loading:
            add(childController: makeInfoViewController())
        case .presenting(let recipes):
            self.recipes = recipes
            tableView.reloadData()
        case .failed:
            add(childController: makeInfoViewController())
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
        let viewController = controllerFactory.makeInfoViewController()
        viewController.imageView.image = R.image.iconInfoSearch()?.withRenderingMode(.alwaysTemplate)
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
        let cell = tableView.dequeue(type: UITableViewCell.self, indexPath: indexPath)
        let recipe = recipes[indexPath.row]
        cell.textLabel?.font = .body
        cell.textLabel?.textColor = R.color.oil()
        cell.textLabel?.text = recipe.title
        return cell
    }
}

// MARK: - UITableViewDelegate

extension FavoritesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let recipe = recipes[indexPath.row]
        delegate?.favoritesViewController(self, didSelectRecipe: recipe)
    }
}
