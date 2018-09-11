//
//  Food2ForkUITests.swift
//  Food2ForkUITests
//
//  Created by Markov, Vadym on 03/09/2018.
//  Copyright © 2018 FINN.no AS. All rights reserved.
//

import XCTest

final class MainNavigationUITests: XCTestCase {
    var app: XCUIApplication!

    override func setUp() {
        super.setUp()
        app = XCUIApplication()
        app.launchUITests()
    }

    func testTabBarNavigation() {
        // Explore tab
        app.tabBars.buttons.element(boundBy: 0).tap()
        XCTAssertTrue(app.hasNavigationTitle(R.string.localizable.explore()))

        // Search tab
        app.tabBars.buttons.element(boundBy: 1).tap()
        XCTAssertTrue(app.hasNavigationTitle(R.string.localizable.search()))

        // Favorites tab
        app.tabBars.buttons.element(boundBy: 2).tap()
        XCTAssertTrue(app.hasNavigationTitle(R.string.localizable.favorites()))
    }
}
