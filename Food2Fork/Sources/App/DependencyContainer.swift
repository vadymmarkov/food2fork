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
    private let imageLoader = ImageLoader()
    private let modelController = ModelController()

    private lazy var networking: Networking<Endpoint> = {
        let networking = Networking<Endpoint>(
            mockProvider: Utilities.isUITesting ? self.mockProvider: self.mockProvider
        )
        Endpoint.configure(with: self.apiConfig)
        networking.beforeEach = { request in
            return request.adding(parameters: ["key": self.apiConfig.key], headers: [:])
        }
        return networking
    }()

    private let mockProvider = MockProvider<Endpoint>(delay: 1.0) { endpoint in
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

// MARK: - AppControllerFactory

extension DependencyContainer: AppControllerFactory {
    func makeAppFlowController() -> AppFlowController {
        return AppFlowController(controllerFactory: self)
    }
}

// MARK: - MainControllerFactory

extension DependencyContainer: MainControllerFactory {
    func makeLaunchViewController() -> UIViewController {
        return R.storyboard.launchScreen().instantiateInitialViewController()!
    }

    func makeMainTabBarController() -> MainTabBarController {
        return MainTabBarController(controllerFactory: self)
    }
}

// MARK: - FlowControllerFactory

extension DependencyContainer: FlowControllerFactory {
    func makeExploreFlowController() -> ExploreFlowController {
        let controller = ExploreFlowController(controllerFactory: self)
        controller.tabBarItem = UITabBarItem(
            title: R.string.localizable.explore(),
            image: R.image.tabExplore(),
            selectedImage: nil
        )
        return controller
    }

    func makeSearchFlowController() -> SearchFlowController {
        let controller = SearchFlowController(controllerFactory: self)
        controller.tabBarItem = UITabBarItem(
            title: R.string.localizable.search(),
            image: R.image.tabSearch(),
            selectedImage: nil
        )
        return controller
    }

    func makeFavoritesFlowController() -> FavoritesFlowController {
        let controller = FavoritesFlowController(controllerFactory: self)
        controller.tabBarItem = UITabBarItem(
            title: R.string.localizable.favorites(),
            image: R.image.tabFavorites(),
            selectedImage: nil
        )
        return controller
    }
}

// MARK: - ExploreControllerFactory

extension DependencyContainer: ExploreControllerFactory {
    func makeExploreViewController() -> ExploreViewController {
        let logicController = ExploreLogicController(networking: networking, modelController: modelController)
        return ExploreViewController(
            controllerFactory: self,
            logicController: logicController,
            imageLoader: imageLoader
        )
    }
}

// MARK: - SearchControllerFactory

extension DependencyContainer: SearchControllerFactory {
    func makeSearchViewController() -> SearchViewController {
        return SearchViewController(
            controllerFactory: self,
            logicController: SearchLogicController(networking: networking)
        )
    }
}

// MARK: - SearchControllerFactory

extension DependencyContainer: FavoritesControllerFactory {
    func makeFavoritesViewController() -> FavoritesViewController {
        return FavoritesViewController(
            controllerFactory: self,
            logicController: FavoritesLogicController(modelController: modelController),
            imageLoader: imageLoader
        )
    }
}

// MARK: - SearchControllerFactory

extension DependencyContainer: RecipeControllerFactory {
    func makeRecipeViewController(with recipe: Recipe) -> RecipeViewController {
        return RecipeViewController(
            recipe: recipe,
            controllerFactory: self,
            logicController: RecipeLogicController(
                networking: networking,
                modelController: modelController
            ),
            imageLoader: imageLoader
        )
    }
}

// MARK: - SearchControllerFactory

extension DependencyContainer: InfoControllerFactory {
    func makeInfoViewController() -> InfoViewController {
        return InfoViewController()
    }

    func makeInfoViewController(with error: Error) -> InfoViewController {
        let viewController = InfoViewController()
        viewController.titleLabel.text = R.string.localizable.errorTitle()
        viewController.textLabel.text = error.localizedDescription
        viewController.button.setTitle(R.string.localizable.errorButton(), for: .normal)
        viewController.imageView.image = R.image.logo()?.withRenderingMode(.alwaysTemplate)
        return viewController
    }
}
