//
//  DependencyContainer.swift
//  Food2Fork
//
//  Created by Markov, Vadym on 04/09/2018.
//  Copyright © 2018 FINN.no AS. All rights reserved.
//

import UIKit

final class DependencyContainer {

}

// MARK: - Controller Factory

extension DependencyContainer: ControllerFactory {
    func makeAppFlowController() -> AppFlowController {
        return AppFlowController()
    }

    func makeMainTabBarController() -> MainTabBarController {
        return MainTabBarController()
    }

    func makeExploreNavigationController() -> ExploreNavigationController {
        let controller = ExploreNavigationController(controllerFactory: self)
        controller.tabBarItem = UITabBarItem(
            title: R.string.localizable.explore(),
            image: R.image.tabExplore(),
            selectedImage: nil
        )
        return controller
    }

    func makeSearchNavigationController() -> SearchNavigationController {
        let controller = SearchNavigationController(controllerFactory: self)
        controller.tabBarItem = UITabBarItem(
            title: R.string.localizable.search(),
            image: R.image.tabSearch(),
            selectedImage: nil
        )
        return controller
    }

    func makeFavoritesNavigationController() -> FavoritesNavigationController {
        let controller = FavoritesNavigationController(controllerFactory: self)
        controller.tabBarItem = UITabBarItem(
            title: R.string.localizable.favorites(),
            image: R.image.tabFavorites(),
            selectedImage: nil
        )
        return controller
    }
}
