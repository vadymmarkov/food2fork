//
//  ExploreFlowControllerTests.swift
//  Food2ForkTests
//
//  Created by Markov, Vadym on 10/09/2018.
//  Copyright © 2018 FINN.no AS. All rights reserved.
//

import XCTest
@testable import Food2Fork

final class ExploreFlowControllerTests: XCTestCase {
    private var controller: ExploreFlowController!
    private let container = DependencyContainer()

    override func setUp() {
        super.setUp()
        controller = ExploreFlowController(controllerFactory: container)
        controller.viewDidLoad()
    }

    // MARK: - Tests

    func testViewDidLoad() {
        XCTAssertEqual(controller.view.backgroundColor, R.color.seashell())
        XCTAssertTrue(controller.topViewController is ExploreViewController)
        XCTAssertTrue((controller.topViewController as? ExploreViewController)?.delegate === controller)
    }
}
