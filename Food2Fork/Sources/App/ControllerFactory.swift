//
//  ControllerFactory.swift
//  Food2Fork
//
//  Created by Markov, Vadym on 04/09/2018.
//  Copyright © 2018 FINN.no AS. All rights reserved.
//

import UIKit

// MARK: - ControllerFactory

protocol ControllerFactory {
    func makeAppFlowController() -> AppFlowController

    func makeLaunchViewController() -> UIViewController
    func makeMainTabBarController() -> MainTabBarController

    func makeExploreFlowController() -> ExploreFlowController
    func makeExploreViewController() -> ExploreViewController

    func makeSearchFlowController() -> SearchFlowController
    func makeSearchViewController() -> SearchViewController

    func makeFavoritesFlowController() -> FavoritesFlowController
    func makeFavoritesViewController() -> FavoritesViewController

    func makeRecipeViewController(with recipe: Recipe) -> RecipeViewController
    func makeInfoViewController() -> InfoViewController
    func makeErrorViewController(with error: Error) -> InfoViewController
}
