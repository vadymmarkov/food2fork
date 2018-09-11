//
//  RootViewController.swift
//  Food2Fork
//
//  Created by Markov, Vadym on 04/09/2018.
//  Copyright © 2018 FINN.no AS. All rights reserved.
//

import UIKit

final class RootViewController: UIViewController {
    private let viewControllerFactory: MainViewControllerFactory

    // MARK: - Init

    init(viewControllerFactory: MainViewControllerFactory) {
        self.viewControllerFactory = viewControllerFactory
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = R.color.seashell()
        startLaunch()
    }
}

// MARK: - Flow

private extension RootViewController {
    func startLaunch() {
        let launchViewController = viewControllerFactory.makeLaunchViewController()
        let snapshotView = launchViewController.view.makeSnapshot()
        let transitionManager = LaunchTransitionManager()

        startMain()
        transitionManager.animateAppearance(of: self, snapshotView: snapshotView)
    }

    func startMain() {
        let viewController = viewControllerFactory.makeMainViewController()
        add(childController: viewController)
    }
}
