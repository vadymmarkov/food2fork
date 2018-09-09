//
//  FavoritesFlowController.swift
//  Food2Fork
//
//  Created by Markov, Vadym on 04/09/2018.
//  Copyright © 2018 FINN.no AS. All rights reserved.
//

import UIKit

final class FavoritesFlowController: UINavigationController {
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
        startFavorites()
    }
}

// MARK: - Flow

private extension FavoritesFlowController {
    func startFavorites() {
        let viewController = controllerFactory.makeFavoritesViewController()
        viewController.delegate = self
        setViewControllers([viewController], animated: false)
    }

    func startRecipeDetail(with recipe: Recipe) {
        let viewController = controllerFactory.makeRecipeViewController(with: recipe)
        pushViewController(viewController, animated: true)
    }
}

// MARK: - Delegates

extension FavoritesFlowController: FavoritesViewControllerDelegate {
    func favoritesViewController(_ viewController: FavoritesViewController, didSelectRecipe recipe: Recipe) {
        startRecipeDetail(with: recipe)
    }
}
