//
//  UIButtonBackgroundTests.swift
//  Food2ForkTests
//
//  Created by Markov, Vadym on 10/09/2018.
//  Copyright © 2018 FINN.no AS. All rights reserved.
//

import XCTest
@testable import Food2Fork

final class UIbuttonBackgroundTests: XCTestCase {
    func testSetBackgroundColorForState() {
        let button = UIButton()
        button.setBackgroundColor(UIColor.red, forState: .normal)
        XCTAssertNotNil(button.currentBackgroundImage)
    }
}
