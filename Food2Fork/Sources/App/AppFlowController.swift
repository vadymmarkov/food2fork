//
//  AppFlowController.swift
//  Food2Fork
//
//  Created by Markov, Vadym on 04/09/2018.
//  Copyright © 2018 FINN.no AS. All rights reserved.
//

import UIKit

final class AppFlowController: UIViewController {
    private let controllerFactory: MainControllerFactory

    // MARK: - Init

    init(controllerFactory: MainControllerFactory) {
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
        startLaunch()
    }
}

// MARK: - Flow

private extension AppFlowController {
    func startLaunch() {
        let launchViewController = controllerFactory.makeLaunchViewController()
        let snapshotView = launchViewController.view.makeSnapshot()
        let transitionManager = LaunchTransitionManager()

        startMain()
        transitionManager.animateAppearance(of: self, snapshotView: snapshotView)
    }

    func startMain() {
        let viewController = controllerFactory.makeMainFlowController()
        add(childController: viewController)
    }
}
