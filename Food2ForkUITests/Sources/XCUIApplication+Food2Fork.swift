//
//  XCUIApplication+Food2Fork.swift
//  Food2ForkUITests
//
//  Created by Vadym Markov on 10/09/2018.
//  Copyright © 2018 FINN.no AS. All rights reserved.
//

import XCTest

extension XCUIApplication {
    func launchWithCleanState() {
        launchArguments.append("--reset")
        launchArguments.append("--UITests")
        launch()
    }

    func hasNavigationTitle(_ title: String) -> Bool {
        return navigationBars[title.uppercased()].exists
    }

    var leftNavigationButton: XCUIElement {
        return navigationBars.buttons.element(boundBy: 0)
    }
}
