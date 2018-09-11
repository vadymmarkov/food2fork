//
//  FavoritesFlowControllerTests.swift
//  Food2ForkTests
//
//  Created by Markov, Vadym on 10/09/2018.
//  Copyright © 2018 FINN.no AS. All rights reserved.
//

import XCTest
@testable import Food2Fork

final class FavoritesFlowControllerTests: XCTestCase {
    private var controller: FavoritesFlowController!
    private let container = DependencyContainer()

    override func setUp() {
        super.setUp()
        controller = FavoritesFlowController(controllerFactory: container)
        controller.viewDidLoad()
    }

    // MARK: - Tests

    func testViewDidLoad() {
        XCTAssertEqual(controller.view.backgroundColor, R.color.seashell())
        XCTAssertTrue(controller.topViewController is FavoritesViewController)
        XCTAssertTrue((controller.topViewController as? FavoritesViewController)?.delegate === controller)
    }
}
