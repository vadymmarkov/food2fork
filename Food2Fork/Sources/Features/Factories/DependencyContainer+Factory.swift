//
//  DependencyContainer+Factory.swift
//  Food2Fork
//
//  Created by Markov, Vadym on 11/09/2018.
//  Copyright © 2018 FINN.no AS. All rights reserved.
//

import UIKit
import SafariServices

// MARK: - UtilityViewControllerFactory

extension DependencyContainer: UtilityViewControllerFactory {
    func makeLoadingViewController() -> LoadingViewController {
        return LoadingViewController()
    }

    func makeInfoViewController() -> InfoViewController {
        let viewController = InfoViewController()
        viewController.button.setTitle(R.string.localizable.retry(), for: .normal)
        viewController.imageView.image = R.image.logo()?.withRenderingMode(.alwaysTemplate)
        return viewController
    }

    func makeInfoViewController(with error: Error) -> InfoViewController {
        let viewController = makeInfoViewController()
        viewController.titleLabel.text = R.string.localizable.errorTitle()
        viewController.textLabel.text = error.localizedDescription
        return viewController
    }
}

// MARK: - SystemViewControllerFactory

extension DependencyContainer: SystemViewControllerFactory {
    func makeAlertController(text: String, handler: ((UIAlertAction) -> Void)? = nil) -> UIAlertController {
        let alertController = UIAlertController(title: nil, message: text, preferredStyle: .alert)
        let action = UIAlertAction(title: R.string.localizable.ok(), style: .default, handler: handler)

        alertController.view.tintColor = R.color.brand()
        alertController.addAction(action)
        return alertController
    }

    func makeWebViewController(for url: URL) -> UIViewController {
        let viewController = SFSafariViewController(url: url)
        viewController.preferredControlTintColor = R.color.brand()
        return viewController
    }
}
