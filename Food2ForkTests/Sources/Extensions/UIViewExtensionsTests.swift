//
//  UICollectionViewReusableCellsTests.swift
//  Food2ForkTests
//
//  Created by Markov, Vadym on 10/09/2018.
//  Copyright © 2018 FINN.no AS. All rights reserved.
//

import XCTest
@testable import Food2Fork

final class UIViewExtensionsTests: XCTestCase {
    private var view: UIView!

    override func setUp() {
        super.setUp()
        view = UIView()
    }

    // MARK: - Tests

    func testIdentifier() {
        XCTAssertEqual(UIView.identifier, String(reflecting: UIView.self))
    }

    func testAddSubviews() {
        view.addSubviews(UIView(), UIView())
        XCTAssertEqual(view.subviews.count, 2)
    }
}
