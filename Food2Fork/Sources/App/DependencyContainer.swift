//
//  DependencyContainer.swift
//  Food2Fork
//
//  Created by Markov, Vadym on 04/09/2018.
//  Copyright © 2018 FINN.no AS. All rights reserved.
//

import UIKit
import Malibu

final class DependencyContainer {
    private let apiConfig = APIConfig()
    private lazy var networking: Networking<Endpoint> = {
        let networking = Networking<Endpoint>.init(mockProvider: self.mockProvider)
        Endpoint.configure(with: self.apiConfig)
        networking.beforeEach = { request in
            return request.adding(parameters: ["key": self.apiConfig.key], headers: [:])
        }
        return networking
    }()

    let mockProvider = MockProvider<Endpoint>(delay: 1.0) { endpoint in
        switch endpoint {
        case .explore:
            return Mock(fileName: "recipes.json")
        case .search:
            return Mock(fileName: "recipes.json")
        case .recipe:
            return Mock(fileName: "recipe.json")
        }
    }
}

// MARK: - Controller Factory

extension DependencyContainer: ControllerFactory {
    func makeAppFlowController() -> AppFlowController {
        return AppFlowController(controllerFactory: self)
    }

    func makeMainTabBarController() -> MainTabBarController {
        return MainTabBarController(controllerFactory: self)
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

    func makeExploreViewController() -> ExploreViewController {
        let logicController = ExploreLogicController(networking: networking)
        return ExploreViewController(logicController: logicController)
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

    func makeSearchViewController() -> SearchViewController {
        return SearchViewController()
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

    func makeFavoritesViewController() -> FavoritesViewController {
        return FavoritesViewController()
    }
}
