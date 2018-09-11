//
//  SystemPresenter.swift
//  Food2Fork
//
//  Created by Markov, Vadym on 11/09/2018.
//  Copyright © 2018 FINN.no AS. All rights reserved.
//

import UIKit

final class SystemPresenter {
    enum Resource {
        case url(URL)
        case alert(String)
    }

    private let viewControllerFactory: SystemViewControllerFactory

    init(viewControllerFactory: SystemViewControllerFactory) {
        self.viewControllerFactory = viewControllerFactory
    }

    // MARK: - Presenter

    func present(_ resource: Resource, in viewController: UIViewController) {
        let presentedViewController = makeViewController(for: resource)
        viewController.present(presentedViewController, animated: true, completion: nil)
    }

    private func makeViewController(for resource: Resource) -> UIViewController {
        switch resource {
        case let .url(url):
            return viewControllerFactory.makeWebViewController(for: url)
        case let .alert(text):
            return viewControllerFactory.makeAlertController(text: text, handler: nil)
        }
    }
}
