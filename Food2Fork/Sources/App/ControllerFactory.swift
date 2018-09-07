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
    func makeMainTabBarController() -> MainTabBarController

    func makeExploreFlowController() -> ExploreFlowController
    func makeExploreViewController() -> ExploreViewController

    func makeSearchFlowController() -> SearchFlowController

    func makeFavoritesFlowController() -> FavoritesFlowController
    func makeFavoritesViewController() -> FavoritesViewController

    func makeSearchViewController(delegate: SearchResultsViewControllerDelegate?) -> UIViewController
}