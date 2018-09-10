//
//  UIViewControllerChildTests.swift
//  Food2ForkTests
//
//  Created by Markov, Vadym on 10/09/2018.
//  Copyright © 2018 FINN.no AS. All rights reserved.
//

import XCTest
@testable import Food2Fork

final class UIViewControllerChildTests: XCTestCase {
    private var parentController: UIViewController!

    override func setUp() {
        super.setUp()
        parentController = UIViewController()
    }

    // MARK: - Tests

    func testAddChildController() {
        let childController = TestViewController()
        parentController.add(childController: childController)
        XCTAssertEqual(childController.actions, [.willMove, .didMove])
        XCTAssertEqual(childController.view.superview, parentController.view)
        XCTAssertEqual(childController.parent, parentController)
    }

    func testRemoveFromParent() {
        let childController = TestViewController()
        parentController.add(childController: childController)
        childController.removeFromParent()

        XCTAssertEqual(childController.actions, [.willMove, .didMove, .willMove, .didMove])
        XCTAssertNil(childController.view.superview)
        XCTAssertNil(childController.parent)
    }

    func testRemoveAllChildControllers() {
        parentController.add(childController: UIViewController())
        parentController.add(childController: UIViewController())
        XCTAssertEqual(parentController.childViewControllers.count, 2)

        parentController.removeAllChildControllers()
        XCTAssertTrue(parentController.childViewControllers.isEmpty)
    }
}

// MARK: - Private

private final class TestViewController: UIViewController {
    var actions = [Action]()

    override func willMove(toParentViewController parent: UIViewController?) {
        actions.append(.willMove)
    }

    override func didMove(toParentViewController parent: UIViewController?) {
        actions.append(.didMove)
    }
}

private enum Action {
    case willMove
    case didMove
}
