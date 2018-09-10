//
//  AppearanceConfiguratorTests.swift
//  Food2ForkTests
//
//  Created by Markov, Vadym on 10/09/2018.
//  Copyright © 2018 FINN.no AS. All rights reserved.
//

import XCTest
@testable import Food2Fork

final class AppearanceConfiguratorTests: XCTestCase {
    private var configurator: AppearanceConfigurator!

    override func setUp() {
        super.setUp()
        configurator = AppearanceConfigurator()
    }

    // MARK: - Tests

    func testConfigure() {
        let navigationBar = UINavigationBar.appearance()
        XCTAssertEqual(navigationBar.tintColor, R.color.brand())
        XCTAssertEqual(navigationBar.titleTextAttributes![.font] as? UIFont, UIFont.title)
        XCTAssertEqual(navigationBar.titleTextAttributes![.foregroundColor] as? UIColor, R.color.oil()!)

        let searchBarButtonItem = UIBarButtonItem.appearance(whenContainedInInstancesOf: [UISearchBar.self])
        XCTAssertEqual(searchBarButtonItem.tintColor, R.color.brand())
    }
}
