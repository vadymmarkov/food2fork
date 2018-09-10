//
//  NSLayoutConstraintsExtensionsTests.swift
//  Food2ForkTests
//
//  Created by Markov, Vadym on 10/09/2018.
//  Copyright © 2018 FINN.no AS. All rights reserved.
//

import XCTest
@testable import Food2Fork

final class NSLayoutConstraintsExtensionsTests: XCTestCase {
    func testConstrain() {
        let view = UIView()
        let viewA = UIView()
        let viewB = UIView()

        view.addSubview(viewB)
        viewB.addSubview(viewA)

        let constraints = NSLayoutConstraint.constrain(
            activate: false,
            viewA.centerXAnchor.constraint(equalTo: viewB.centerXAnchor),
            viewA.centerYAnchor.constraint(equalTo: viewB.centerYAnchor),
            viewB.leadingAnchor.constraint(equalTo: view.leadingAnchor)
        )

        XCTAssertEqual(constraints.count, 3)
        XCTAssertFalse(viewA.translatesAutoresizingMaskIntoConstraints)
        XCTAssertFalse(viewB.translatesAutoresizingMaskIntoConstraints)

        XCTAssertEqual(constraints[0].isActive, false)
        XCTAssertEqual(constraints[0].firstAnchor, viewA.centerXAnchor)
        XCTAssertEqual(constraints[0].secondAnchor, viewB.centerXAnchor)

        XCTAssertEqual(constraints[1].isActive, false)
        XCTAssertEqual(constraints[1].firstAnchor, viewA.centerYAnchor)
        XCTAssertEqual(constraints[1].secondAnchor, viewB.centerYAnchor)
    }

    func testPin() {
        let viewA = UIView()
        let viewB = UIView()
        let insets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        viewB.addSubview(viewA)

        let constraints = NSLayoutConstraint.pin(viewA, toView: viewB, insets: insets)

        XCTAssertEqual(constraints[0].constant, insets.left)
        XCTAssertEqual(constraints[1].constant, -insets.right)
        XCTAssertEqual(constraints[2].constant, insets.top)
        XCTAssertEqual(constraints[3].constant, -insets.bottom)
    }
}
