//
//  EndpointTests.swift
//  Food2ForkTests
//
//  Created by Markov, Vadym on 11/09/2018.
//  Copyright © 2018 FINN.no AS. All rights reserved.
//

import XCTest
@testable import Food2Fork

final class EndpointTests: XCTestCase {
    override func tearDown() {
        super.tearDown()
        Endpoint.baseUrl = nil
        Endpoint.headers = [:]
    }

    func testConfigure() {
        let apiConfig = APIConfig()
        Endpoint.configure(with: apiConfig)

        XCTAssertEqual(Endpoint.baseUrl?.urlString, apiConfig.baseUrl)
        XCTAssertEqual(Endpoint.headers, ["Accept": apiConfig.acceptHeader])
    }
}
