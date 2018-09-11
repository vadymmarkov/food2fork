//
//  XCUIElement+Food2Fork.swift
//  Food2ForkUITests
//
//  Created by Vadym Markov on 11/09/2018.
//  Copyright © 2018 FINN.no AS. All rights reserved.
//

import XCTest

extension XCUIElement {
    func waitForExistenceAndTap(timeout: TimeInterval) {
        _ = waitForExistence(timeout: timeout)
        tap()
    }
}
