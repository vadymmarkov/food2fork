//
//  AppFlowControllerTests.swift
//  Food2ForkTests
//
//  Created by Markov, Vadym on 10/09/2018.
//  Copyright © 2018 FINN.no AS. All rights reserved.
//

import XCTest
@testable import Food2Fork

final class AppFlowControllerTests: XCTestCase {
    private var controller: AppFlowController!
    private let container = DependencyContainer()

    override func setUp() {
        super.setUp()
        controller = AppFlowController(controllerFactory: container)
    }

    // MARK: - Tests

    func testViewDidLoad() {
        controller.viewDidLoad()
        XCTAssertTrue(controller.childViewControllers.first is MainFlowController)
    }
}
