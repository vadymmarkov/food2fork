//
//  SearchFlowControllerTests.swift
//  Food2ForkTests
//
//  Created by Markov, Vadym on 11/09/2018.
//  Copyright © 2018 FINN.no AS. All rights reserved.
//

import XCTest
@testable import Food2Fork

final class SearchFlowControllerTests: XCTestCase {
    private var controller: SearchFlowController!
    private let container = DependencyContainer()

    override func setUp() {
        super.setUp()
        controller = SearchFlowController(controllerFactory: container)
        controller.viewDidLoad()
    }

    // MARK: - Tests

    func testViewDidLoad() {
        XCTAssertEqual(controller.view.backgroundColor, R.color.seashell())
        XCTAssertTrue(controller.topViewController is SearchViewController)
        XCTAssertTrue((controller.topViewController as? SearchViewController)?.delegate === controller)
    }
}
