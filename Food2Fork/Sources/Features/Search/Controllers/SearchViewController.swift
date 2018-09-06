//
//  SearchViewController.swift
//  Food2Fork
//
//  Created by Markov, Vadym on 05/09/2018.
//  Copyright © 2018 FINN.no AS. All rights reserved.
//

import UIKit

final class SearchFlowController: UIViewController {
    private let logicController: SearchLogicController
    private let controllerFactory: ControllerFactory
    private lazy var searchController = UISearchController(
        searchResultsController: SearchResultsViewController()
    )

    // MARK: - Init

    init(logicController: SearchLogicController) {
        self.logicController = logicController
        self.controllerFactory = controllerFactory
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = R.color.seashell()
        navigationItem.title = R.string.localizable.search()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        render(.info)
        logicController.loadRecentSearches(then: { [weak self] state in
            self?.render(state)
        })
    }

    // MARK: - Rendering

    func render(_ state: SearchState) {
        switch state {
        case .info:
            showInfo()
        default:
            break
        }
    }

    private func showInfo() {
        let viewController = controllerFactory.makeInfoViewController(
            image: R.image.tabSearch(),
            title: R.string.localizable.searchInfoTitle(),
            text: R.string.localizable.searchInfoText()
        )
        add(childController: viewController)

        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = R.string.localizable.searchPlaceholder()
        navigationItem.searchController = searchController
        definesPresentationContext = true
    }
}

extension SearchFlowController: UISearchResultsUpdating {
    // MARK: - UISearchResultsUpdating Delegate
    func updateSearchResults(for searchController: UISearchController) {
        let searchBar = searchController.searchBar

    }
}
