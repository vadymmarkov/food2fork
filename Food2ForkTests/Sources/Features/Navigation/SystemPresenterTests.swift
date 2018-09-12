//
//  SystemPresenterTests.swift
//  Food2ForkTests
//
//  Created by Markov, Vadym on 12/09/2018.
//  Copyright © 2018 FINN.no AS. All rights reserved.
//

import XCTest
import SafariServices
@testable import Food2Fork

final class SystemPresenterTests: XCTestCase {
    private var presenter: SystemPresenter!
    private var viewController: ViewController!

    override func setUp() {
        super.setUp()
        presenter = SystemPresenter(viewControllerFactory: DependencyContainer())
        viewController = ViewController()
    }

    // MARK: - Tests

    func testPresentUrl() {
        presenter.present(.url(URL(string: "https://test.com")!), in: viewController)
        XCTAssertTrue(viewController.viewControllerToPresent is SFSafariViewController)
    }

    func testPresentAlert() {
        presenter.present(.alert("Test"), in: viewController)
        XCTAssertTrue(viewController.viewControllerToPresent is UIAlertController)
    }
}

// MARK: - Mocks

private final class ViewController: UIViewController {
    var viewControllerToPresent: UIViewController?

    override func present(_ viewControllerToPresent: UIViewController,
                          animated flag: Bool,
                          completion: (() -> Void)? = nil) {
        self.viewControllerToPresent = viewControllerToPresent
        super.present(viewControllerToPresent, animated: false, completion: completion)
    }
}
