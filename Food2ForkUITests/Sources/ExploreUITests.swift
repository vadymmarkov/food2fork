//
//  ExploreUITests.swift
//  Food2ForkUITests
//
//  Created by Vadym Markov on 11/09/2018.
//  Copyright © 2018 FINN.no AS. All rights reserved.
//

import XCTest

final class ExploreUITests: XCTestCase {
    var app: XCUIApplication!

    override func setUp() {
        super.setUp()
        continueAfterFailure = false
        app = XCUIApplication()
        app.launchUITests()
    }

    func testOpenRecipeDetail() {
        // Open explore list
        app.tabBars.buttons.element(boundBy: 0).tap()
        XCTAssertTrue(app.isDisplayingExplore)

        // Push recipe detail
        app.collectionViews.cells.element(boundBy: 0).tap()
        XCTAssertTrue(app.isDisplayingRecipeDetail)

        // Go back to explore list
        app.leftNavigationButton.tap()
        XCTAssertTrue(app.isDisplayingExplore)
    }
}

// MARK: - Private

private extension XCUIApplication {
    var isDisplayingExplore: Bool {
        return hasNavigationTitle(R.string.localizable.explore())
    }
}
