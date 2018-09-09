//
//  LaunchTransitionManager.swift
//  Food2Fork
//
//  Created by Vadym Markov on 09/09/2018.
//  Copyright © 2018 FINN.no AS. All rights reserved.
//

import UIKit

final class LaunchTransitionManager {
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
