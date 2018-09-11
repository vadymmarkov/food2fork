//
//  FavoritesUITests.swift
//  Food2ForkUITests
//
//  Created by Vadym Markov on 11/09/2018.
//  Copyright © 2018 FINN.no AS. All rights reserved.
//

import XCTest

final class FavoritesUITests: XCTestCase {
    var app: XCUIApplication!

    override func setUp() {
        super.setUp()
        continueAfterFailure = false
        app = XCUIApplication()
        app.launchUITests()
    }

    func testFavorites() {
        // Open empty favorites list
        app.tabBars.buttons.element(boundBy: 2).tap()
        XCTAssertTrue(app.isDisplayingFavorites)
        XCTAssertTrue(app.isDisplayingFavoritesInfo)

        // Like recipe
        app.tabBars.buttons.element(boundBy: 0).tap()
        app.collectionViews.cells.element(boundBy: 0).tap()
        app.rightNavigationButton.tap()
        app.leftNavigationButton.tap()

        // Open favorites list
        app.tabBars.buttons.element(boundBy: 2).tap()
        XCTAssertTrue(app.isDisplayingFavorites)
        XCTAssertFalse(app.isDisplayingFavoritesInfo)

        // Push recipe detail
        app.tables.cells.element(boundBy: 0).waitForExistenceAndTap(timeout: 1)
        XCTAssertTrue(app.isDisplayingRecipeDetail)

        // Unlike recipe
        app.rightNavigationButton.tap()

        // Go back to favorites list
        app.leftNavigationButton.tap()
        XCTAssertTrue(app.isDisplayingFavorites)
        XCTAssertTrue(app.isDisplayingFavoritesInfo)
    }
}

// MARK: - Private

private extension XCUIApplication {
    var isDisplayingFavorites: Bool {
        return hasNavigationTitle(R.string.localizable.favorites())
    }

    var isDisplayingFavoritesInfo: Bool {
        return staticTexts[R.string.localizable.favoritesInfoTitle()].exists
            && staticTexts[R.string.localizable.favoritesInfoText()].exists
    }
}
