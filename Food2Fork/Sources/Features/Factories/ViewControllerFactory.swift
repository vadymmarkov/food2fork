//
//  ViewControllerFactory.swift
//  Food2Fork
//
//  Created by Markov, Vadym on 04/09/2018.
//  Copyright © 2018 FINN.no AS. All rights reserved.
//

import UIKit

protocol RootViewControllerFactory {
    func makeRootViewController() -> RootViewController
}

protocol MainViewControllerFactory {
    func makeLaunchViewController() -> UIViewController
    func makeMainViewController() -> UIViewController
}

protocol NavigationControllerFactory {
    func makeExploreNavigationController() -> UINavigationController
    func makeSearchNavigationController() -> UINavigationController
    func makeFavoritesNavigationController() -> UINavigationController
}

protocol ExploreViewControllerFactory {
    func makeExploreViewController(navigator: RecipeNavigator) -> ExploreViewController
}

protocol SearchViewControllerFactory {
    func makeSearchViewController(navigator: RecipeNavigator) -> SearchViewController
}

protocol FavoritesViewControllerFactory {
    func makeFavoritesViewController(navigator: RecipeNavigator) -> FavoritesViewController
}

protocol RecipeViewControllerFactory {
    func makeRecipeViewController(with recipe: Recipe) -> RecipeViewController
}

protocol UtilityViewControllerFactory {
    func makeLoadingViewController() -> LoadingViewController
    func makeInfoViewController() -> InfoViewController
    func makeInfoViewController(with error: Error) -> InfoViewController
}

protocol SystemViewControllerFactory {
    func makeAlertController(text: String, handler: ((UIAlertAction) -> Void)?) -> UIAlertController
    func makeWebViewController(for url: URL) -> UIViewController
}
