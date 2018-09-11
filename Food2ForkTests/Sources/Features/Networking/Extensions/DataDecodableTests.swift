//
//  DataDecodableTests.swift
//  Food2ForkTests
//
//  Created by Markov, Vadym on 11/09/2018.
//  Copyright © 2018 FINN.no AS. All rights reserved.
//

import XCTest
import Malibu
@testable import Food2Fork

final class DataDecodableTests: XCTestCase {
    func testDecoded() throws {
        let data = try JSONEncoder().encode(Recipe.makeStub())
        let recipe: Recipe = try data.decoded()
        XCTAssertNotNil(recipe)
    }
}
