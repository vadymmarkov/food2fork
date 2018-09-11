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
    private var parentViewController: UIViewController!

    override func setUp() {
        super.setUp()
        parentViewController = UIViewController()
    }

    // MARK: - Tests

    func testAddChildViewController() {
        let childViewController = TestViewController()
        parentViewController.add(childViewController: childViewController)
        XCTAssertEqual(childViewController.actions, [.willMove, .didMove])
        XCTAssertEqual(childViewController.view.superview, parentViewController.view)
        XCTAssertEqual(childViewController.parent, parentViewController)
    }

    func testRemoveFromParent() {
        let childViewController = TestViewController()
        parentViewController.add(childViewController: childViewController)
        childViewController.removeFromParent()

        XCTAssertEqual(childViewController.actions, [.willMove, .didMove, .willMove, .didMove])
        XCTAssertNil(childViewController.view.superview)
        XCTAssertNil(childViewController.parent)
    }

    func testRemoveAllChildViewControllers() {
        parentViewController.add(childViewController: UIViewController())
        parentViewController.add(childViewController: UIViewController())
        XCTAssertEqual(parentViewController.childViewControllers.count, 2)

        parentViewController.removeAllChildViewControllers()
        XCTAssertTrue(parentViewController.childViewControllers.isEmpty)
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
