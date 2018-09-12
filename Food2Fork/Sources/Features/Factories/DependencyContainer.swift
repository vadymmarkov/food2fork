//
//  DependencyContainer.swift
//  Food2Fork
//
//  Created by Markov, Vadym on 04/09/2018.
//  Copyright © 2018 FINN.no AS. All rights reserved.
//

import UIKit
import Malibu
import CoreData
import SafariServices

final class DependencyContainer {
    private let apiConfig = APIConfig()
    private let imageLoader = ImageLoader()

    private lazy var networking: Networking<Endpoint> = {
        let networking = Networking<Endpoint>(
            mockProvider: isTesting ? self.mockProvider: nil
        )
        networking.beforeEach = { request in
            return request.adding(parameters: ["key": self.apiConfig.key], headers: [:])
        }
        return networking
    }()

    private let mockProvider = MockProvider<Endpoint>(resolver: { endpoint in
        switch endpoint {
        case .explore:
            return Mock(fileName: "recipes.json")
        case .search:
            return Mock(fileName: "recipes.json")
        case .recipe:
            return Mock(fileName: "recipe.json")
        }
    })

    private lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Food2Fork")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                print("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    /// For unit and UI testing only
    private lazy var inMemoryManagedContext: NSManagedObjectContext = .makeInMemoryContext()

    private var store: NSManagedObjectContext {
        return isTesting ? inMemoryManagedContext : persistentContainer.viewContext
    }

    init() {
        Endpoint.configure(with: self.apiConfig)
        #if DEBUG
            Malibu.logger.level = .verbose
        #else
            Malibu.logger.level = .error
        #endif
    }
}

// MARK: - AppControllerFactory

extension DependencyContainer: RootViewControllerFactory {
    func makeRootViewController() -> RootViewController {
        return RootViewController(viewControllerFactory: self)
    }
}

// MARK: - MainControllerFactory

extension DependencyContainer: MainViewControllerFactory {
    func makeLaunchViewController() -> UIViewController {
        return R.storyboard.launchScreen().instantiateInitialViewController()!
    }

    func makeMainViewController() -> UIViewController {
        let viewControllers = [
            makeExploreNavigationController(),
            makeSearchNavigationController(),
            makeFavoritesNavigationController()
        ]

        let tabBarController = UITabBarController()
        tabBarController.tabBar.tintColor = R.color.brand()
        tabBarController.setViewControllers(viewControllers, animated: false)

        return tabBarController
    }
}

// MARK: - FlowControllerFactory

extension DependencyContainer {
    func makeExploreNavigationController() -> UINavigationController {
        let navigationController = UINavigationController()
        let navigator = RecipeNavigator(navigationController: navigationController, viewControllerFactory: self)
        let viewController = makeExploreViewController(navigator: navigator)

        navigationController.setViewControllers([viewController], animated: false)
        navigationController.tabBarItem = UITabBarItem(
            title: R.string.localizable.explore(),
            image: R.image.tabExplore(),
            selectedImage: nil
        )

        return navigationController
    }

    func makeSearchNavigationController() -> UINavigationController {
        let navigationController = UINavigationController()
        let navigator = RecipeNavigator(navigationController: navigationController, viewControllerFactory: self)
        let viewController = makeSearchViewController(navigator: navigator)

        navigationController.setViewControllers([viewController], animated: false)
        navigationController.tabBarItem = UITabBarItem(
            title: R.string.localizable.search(),
            image: R.image.tabSearch(),
            selectedImage: nil
        )

        return navigationController
    }

    func makeFavoritesNavigationController() -> UINavigationController {
        let navigationController = UINavigationController()
        let navigator = RecipeNavigator(navigationController: navigationController, viewControllerFactory: self)
        let viewController = makeFavoritesViewController(navigator: navigator)

        navigationController.setViewControllers([viewController], animated: false)
        navigationController.tabBarItem = UITabBarItem(
            title: R.string.localizable.favorites(),
            image: R.image.tabFavorites(),
            selectedImage: nil
        )

        return navigationController
    }
}

// MARK: - ExploreViewControllerFactory

extension DependencyContainer: ExploreViewControllerFactory {
    func makeExploreViewController(navigator: RecipeNavigator) -> ExploreViewController {
        let logicController = ExploreLogicController(networking: networking, store: store)
        return ExploreViewController(
            viewControllerFactory: self,
            navigator: navigator,
            logicController: logicController,
            imageLoader: imageLoader
        )
    }
}

// MARK: - SearchViewControllerFactory

extension DependencyContainer: SearchViewControllerFactory {
    func makeSearchViewController(navigator: RecipeNavigator) -> SearchViewController {
        return SearchViewController(
            viewControllerFactory: self,
            navigator: navigator,
            logicController: SearchLogicController(networking: networking)
        )
    }
}

// MARK: - FavoritesViewControllerFactory

extension DependencyContainer: FavoritesViewControllerFactory {
    func makeFavoritesViewController(navigator: RecipeNavigator) -> FavoritesViewController {
        return FavoritesViewController(
            viewControllerFactory: self,
            navigator: navigator,
            logicController: FavoritesLogicController(store: store),
            imageLoader: imageLoader
        )
    }
}

// MARK: - RecipeViewControllerFactory

extension DependencyContainer: RecipeViewControllerFactory {
    func makeRecipeViewController(with recipe: Recipe) -> RecipeViewController {
        return RecipeViewController(
            recipe: recipe,
            presenter: SystemPresenter(viewControllerFactory: self),
            logicController: RecipeLogicController(networking: networking, store: store),
            imageLoader: imageLoader
        )
    }
}
