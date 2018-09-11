//
//  MainFlowControllerTests.swift
//  Food2ForkTests
//
//  Created by Markov, Vadym on 11/09/2018.
//  Copyright © 2018 FINN.no AS. All rights reserved.
//

import XCTest
@testable import Food2Fork

final class MainFlowControllerTests: XCTestCase {
    private var controller: MainFlowController!
    private let container = DependencyContainer()

    override func setUp() {
        super.setUp()
        controller = MainFlowController(controllerFactory: container)
        controller.viewDidLoad()
    }

    // MARK: - Tests

    func testViewDidLoad() {
        XCTAssertEqual(controller.view.backgroundColor, R.color.seashell())
        XCTAssertEqual(controller.tabBar.tintColor, R.color.brand())

        XCTAssertTrue(controller.viewControllers?[0] is ExploreFlowController)
        XCTAssertTrue(controller.viewControllers?[1] is SearchFlowController)
        XCTAssertTrue(controller.viewControllers?[2] is FavoritesFlowController)
    }
}
