//
//  FavoritesNavigationController.swift
//  Food2Fork
//
//  Created by Markov, Vadym on 04/09/2018.
//  Copyright © 2018 FINN.no AS. All rights reserved.
//

import UIKit

final class FavoritesNavigationController: UINavigationController {
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

private extension FavoritesNavigationController {
    func startFavorites() {
        let viewController = controllerFactory.makeFavoritesViewController()
        setViewControllers([viewController], animated: false)
    }
}
