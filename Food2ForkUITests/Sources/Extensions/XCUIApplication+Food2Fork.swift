//
//  XCUIApplication+Food2Fork.swift
//  Food2ForkUITests
//
//  Created by Vadym Markov on 10/09/2018.
//  Copyright © 2018 FINN.no AS. All rights reserved.
//

import XCTest

extension XCUIApplication {
    func launchUITests() {
        launchArguments.append("--UITests")
        launch()
    }

    func hasNavigationTitle(_ title: String) -> Bool {
        return navigationBars[title].exists
    }

    var leftNavigationButton: XCUIElement {
        return navigationBars.buttons.element(boundBy: 0)
    }

    var rightNavigationButton: XCUIElement {
        return navigationBars.buttons.element(boundBy: 1)
    }

    var isDisplayingRecipeDetail: Bool {
        return scrollViews.count == 1 && images.count == 1
    }
}
