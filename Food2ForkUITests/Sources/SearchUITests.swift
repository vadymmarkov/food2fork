//
//  SearchUITests.swift
//  Food2ForkUITests
//
//  Created by Vadym Markov on 11/09/2018.
//  Copyright © 2018 FINN.no AS. All rights reserved.
//

import XCTest

final class SearchUITests: XCTestCase {
    var app: XCUIApplication!

    override func setUp() {
        super.setUp()
        continueAfterFailure = false
        app = XCUIApplication()
        app.launchUITests()
    }

    func testSearch() {
        // Open search screen
        app.tabBars.buttons.element(boundBy: 1).tap()
        XCTAssertTrue(app.hasNavigationTitle(R.string.localizable.search()))
        XCTAssertTrue(app.staticTexts[R.string.localizable.searchInfoTitle()].exists)
        XCTAssertTrue(app.staticTexts[R.string.localizable.searchInfoText()].exists)
        XCTAssertTrue(app.buttons[R.string.localizable.search()].exists)
        XCTAssertEqual(app.searchFields.count, 1)
        XCTAssertEqual(app.tables.cells.count, 0)

        // Start searching
        let searchField = app.searchFields.firstMatch
        searchField.tap()
        searchField.typeText("Test")

        // Push recipe detail
        app.tables.cells.element(boundBy: 0).waitForExistenceAndTap(timeout: 1)
        XCTAssertTrue(app.isDisplayingRecipeDetail)

        // Go back to search
        app.leftNavigationButton.tap()
        XCTAssertTrue(app.isDisplayingSearch)
    }
}

// MARK: - Private

private extension XCUIApplication {
    var isDisplayingSearch: Bool {
        return hasNavigationTitle(R.string.localizable.search())
    }
}
