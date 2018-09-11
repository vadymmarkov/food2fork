//
//  SearchLogicControllerTests.swift
//  Food2ForkTests
//
//  Created by Markov, Vadym on 11/09/2018.
//  Copyright © 2018 FINN.no AS. All rights reserved.
//

import XCTest
import Malibu
import CoreData
@testable import Food2Fork

final class SearchLogicControllerTests: XCTestCase {
    func testSearchWithRecipes() {
        let controller = makeController(withMock: Mock(fileName: "recipes.json"))
        let loadExpectation = expectation(description: "load")

        controller.search(text: "Test", page: 1, then: { state in
            switch state {
            case .presenting(let recipes):
                XCTAssertEqual(recipes.count, 30)
                loadExpectation.fulfill()
            case .loading, .failed:
                XCTFail("Incorrect state: \(state)")
            }
        })

        waitForExpectations(timeout: 1, handler: nil)
    }

    func testLoadWithError() {
        let mock = Mock(httpResponse: nil, data: nil, error: NetworkError.noDataInResponse)
        let controller = makeController(withMock: mock)
        let loadExpectation = expectation(description: "load")

        controller.search(text: "Test", page: 1, then: { state in
            switch state {
            case .failed(let error):
                XCTAssertEqual(error as? NetworkError, NetworkError.noDataInResponse)
                loadExpectation.fulfill()
            case .loading, .presenting:
                XCTFail("Incorrect state: \(state)")
            }
        })

        waitForExpectations(timeout: 1, handler: nil)
    }

    // MARK: - Private

    private func makeController(withMock mock: Mock) -> SearchLogicController {
        let networking = Networking<Endpoint>(mockProvider: MockProvider<Endpoint>(resolver: { endpoint in
            switch endpoint {
            case .search:
                return mock
            default:
                return nil
            }
        }))

        return SearchLogicController(networking: networking)
    }
}
