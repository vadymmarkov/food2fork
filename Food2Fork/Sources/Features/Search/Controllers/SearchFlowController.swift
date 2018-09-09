//
//  SearchFlowController.swift
//  Food2Fork
//
//  Created by Markov, Vadym on 04/09/2018.
//  Copyright © 2018 FINN.no AS. All rights reserved.
//

import UIKit

final class SearchFlowController: UINavigationController {
    private let controllerFactory: ControllerFactory

    // MARK: - Init

    init(controllerFactory: ControllerFactory) {
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
        startSearchInfo()
    }
}

// MARK: - Flow

private extension SearchFlowController {
    func startSearchInfo() {
        let viewController = controllerFactory.makeSearchViewController()
        viewController.delegate = self
        setViewControllers([viewController], animated: false)
    }

    func startRecipeDetail(with recipe: Recipe) {
        let viewController = controllerFactory.makeRecipeViewController(with: recipe)
        pushViewController(viewController, animated: true)
    }
}

// MARK: - Delegates

extension SearchFlowController: SearchViewControllerDelegate {
    func searchViewController(_ viewController: SearchViewController, didSelectRecipe recipe: Recipe) {
        startRecipeDetail(with: recipe)
    }
}
