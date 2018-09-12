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
        start()
    }
}

// MARK: - Flow

private extension RootViewController {
    func start() {
        let launchViewController = viewControllerFactory.makeLaunchViewController()
        let snapshotView = launchViewController.view.makeSnapshot()
        let viewController = viewControllerFactory.makeMainViewController()

        add(childViewController: viewController)
        animateAppearance(of: self, snapshotView: snapshotView)
    }

    func animateAppearance(of viewController: UIViewController, snapshotView: UIImageView) {
        viewController.view.addSubview(snapshotView)

        UIView.animate(
            withDuration: 0.8,
            animations: ({
                snapshotView.transform = CGAffineTransform(scaleX: 2, y: 2)
                snapshotView.alpha = 0
            }),
            completion: ({ _ in
                snapshotView.removeFromSuperview()
            })
        )
    }
}
