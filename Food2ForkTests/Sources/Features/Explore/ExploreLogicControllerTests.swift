//
//  ExploreLogicControllerTests.swift
//  Food2ForkTests
//
//  Created by Markov, Vadym on 10/09/2018.
//  Copyright © 2018 FINN.no AS. All rights reserved.
//

import XCTest
import Malibu
import CoreData
@testable import Food2Fork

final class ExploreLogicControllerTests: XCTestCase {
    private var store: NSManagedObjectContext!

    override func setUp() {
        super.setUp()
        store = NSManagedObjectContext.makeInMemoryContext()
    }

    // MARK: - Tests

    func testLoadWithRecipes() {
        let controller = makeController(withMock: Mock(fileName: "recipes.json"))
        let loadExpectation = expectation(description: "load")

        controller.load(then: { state in
            switch state {
            case .presenting(let recipes):
                XCTAssertEqual(recipes.count, 30)
                XCTAssertTrue(recipes.filter({ $0.isFavorite }).isEmpty)
                loadExpectation.fulfill()
            case .loading, .failed:
                XCTFail("Incorrect state: \(state)")
            }
        })

        waitForExpectations(timeout: 1, handler: nil)
    }

    func testLoadWithFavoriteRecipes() throws {
        let mock = Mock(fileName: "recipes.json")
        let controller = makeController(withMock: mock)
        let recipes = try JSONDecoder().decode(SearchNetworkResponse.self, from: mock.data!).recipes
        let favoriteRecipes = Array(recipes[0...2]).map({ recipe -> Recipe in
            var recipe = recipe
            recipe.isFavorite = true
            return recipe
        })

        for recipe in favoriteRecipes {
            try store.save(recipe)
        }

        let loadExpectation = expectation(description: "load")

        controller.load(then: { state in
            switch state {
            case .presenting(let recipes):
                XCTAssertEqual(recipes.count, 30)

                let filteredRecipes = recipes.filter({ $0.isFavorite })
                XCTAssertEqual(filteredRecipes, favoriteRecipes)
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

        controller.load(then: { state in
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

    private func makeController(withMock mock: Mock) -> ExploreLogicController {
        let networking = Networking<Endpoint>(mockProvider: MockProvider<Endpoint>(resolver: { endpoint in
            switch endpoint {
            case .explore:
                return mock
            default:
                return nil
            }
        }))

        return ExploreLogicController(networking: networking, store: store)
    }
}
