//
//  RecipeNavigator.swift
//  Food2Fork
//
//  Created by Markov, Vadym on 11/09/2018.
//  Copyright © 2018 FINN.no AS. All rights reserved.
//

import UIKit

final class RecipeNavigator: Navigator {
    private weak var navigationController: UINavigationController?
    private let viewControllerFactory: RecipeViewControllerFactory

    init(navigationController: UINavigationController, viewControllerFactory: RecipeViewControllerFactory) {
        self.navigationController = navigationController
        self.viewControllerFactory = viewControllerFactory
    }

    // MARK: - Navigation

    func navigate(to destination: Recipe) {
        let viewController = viewControllerFactory.makeRecipeViewController(with: destination)
        navigationController?.pushViewController(viewController, animated: true)
    }
}
