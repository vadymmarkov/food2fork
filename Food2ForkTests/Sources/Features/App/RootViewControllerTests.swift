//
//  RootViewControllerTests.swift
//  Food2ForkTests
//
//  Created by Markov, Vadym on 10/09/2018.
//  Copyright © 2018 FINN.no AS. All rights reserved.
//

import XCTest
@testable import Food2Fork

final class RootViewControllerTests: XCTestCase {
    private var viewController: RootViewController!
    private let container = DependencyContainer()

    override func setUp() {
        super.setUp()
        viewController = RootViewController(viewControllerFactory: container)
    }

    // MARK: - Tests

    func testViewDidLoad() {
        viewController.viewDidLoad()
        XCTAssertTrue(viewController.childViewControllers.first is UITabBarController)
    }
}
