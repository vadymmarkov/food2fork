//
//  ControllerFactory.swift
//  Food2Fork
//
//  Created by Markov, Vadym on 04/09/2018.
//  Copyright © 2018 FINN.no AS. All rights reserved.
//

import UIKit

// MARK: - ControllerFactory

protocol AppControllerFactory {
    func makeAppFlowController() -> AppFlowController
}

protocol MainControllerFactory {
    func makeLaunchViewController() -> UIViewController
    func makeMainTabBarController() -> MainTabBarController
}

protocol FlowControllerFactory {
    func makeExploreFlowController() -> ExploreFlowController
    func makeSearchFlowController() -> SearchFlowController
    func makeFavoritesFlowController() -> FavoritesFlowController
}

protocol ExploreControllerFactory {
    func makeExploreViewController() -> ExploreViewController
}

protocol SearchControllerFactory {
    func makeSearchViewController() -> SearchViewController
}

protocol FavoritesControllerFactory: RecipeControllerFactory {
    func makeFavoritesViewController() -> FavoritesViewController
}

protocol RecipeControllerFactory {
    func makeRecipeViewController(with recipe: Recipe) -> RecipeViewController
}

protocol InfoControllerFactory {
    func makeInfoViewController() -> InfoViewController
    func makeInfoViewController(with error: Error) -> InfoViewController
    func makeAlertController(text: String, handler: ((UIAlertAction) -> Void)?) -> UIAlertController
}
