//
//  RecipeLogicControllerTests.swift
//  Food2ForkTests
//
//  Created by Markov, Vadym on 11/09/2018.
//  Copyright © 2018 FINN.no AS. All rights reserved.
//

import XCTest
import Malibu
import CoreData
@testable import Food2Fork

final class RecipeLogicControllerTests: XCTestCase {
    private typealias Store = ReadableStore & WritableStore
    private var store: Store!

    override func setUp() {
        super.setUp()
        store = NSManagedObjectContext.makeInMemoryContext()
    }

    // MARK: - Tests

    func testLoad() {
        let controller = makeController(withMock: Mock(fileName: "recipe.json"))
        let loadExpectation = expectation(description: "load")

        controller.load(id: "123", then: { state in
            switch state {
            case .presenting(let recipe):
                XCTAssertFalse(recipe.isFavorite)
                loadExpectation.fulfill()
            case .loading, .failed:
                XCTFail("Incorrect state: \(state)")
            }
        })

        waitForExpectations(timeout: 1, handler: nil)
    }

    func testLoadWhenIsFavorite() throws {
        let mock = Mock(fileName: "recipe.json")
        let controller = makeController(withMock: mock)
        var favoriteRecipe = try JSONDecoder().decode(RecipeNetworkResponse.self, from: mock.data!).recipe

        favoriteRecipe.isFavorite = true
        try store.save(favoriteRecipe)

        let loadExpectation = expectation(description: "load")

        controller.load(id: favoriteRecipe.id, then: { state in
            switch state {
            case .presenting(let recipe):
                XCTAssertTrue(recipe.isFavorite)
                XCTAssertEqual(recipe, favoriteRecipe)
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

        controller.load(id: "123", then: { state in
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

    func testLike() {
        let recipe = Recipe.makeStub()
        let predicate = NSPredicate(format: "uid = %@", recipe.id)
        let controller = makeController(withMock: Mock(fileName: "recipe.json"))
        let likeExpectation = expectation(description: "like")

        controller.like(recipe: recipe, then: { state in
            switch state {
            case .presenting(let recipe):
                XCTAssertTrue(recipe.isFavorite)
                do {
                    let loadedRecipe: Recipe? = try self.store.loadObject(predicate: predicate)
                    XCTAssertNotNil(loadedRecipe)
                    likeExpectation.fulfill()
                } catch {
                    XCTFail("Failed with: \(error)")
                }
            case .loading, .failed:
                XCTFail("Incorrect state: \(state)")
            }
        })

        waitForExpectations(timeout: 1, handler: nil)
    }

    func testUnlike() throws {
        let recipe = Recipe.makeStub()
        let predicate = NSPredicate(format: "uid = %@", recipe.id)
        let controller = makeController(withMock: Mock(fileName: "recipe.json"))
        let unlikeExpectation = expectation(description: "like")

        controller.unlike(recipe: recipe, then: { state in
            switch state {
            case .presenting(let recipe):
                XCTAssertFalse(recipe.isFavorite)
                do {
                    let loadedRecipe: Recipe? = try self.store.loadObject(predicate: predicate)
                    XCTAssertNil(loadedRecipe)
                    unlikeExpectation.fulfill()
                } catch {
                    XCTFail("Failed with: \(error)")
                }
            case .loading, .failed:
                XCTFail("Incorrect state: \(state)")
            }
        })

        waitForExpectations(timeout: 1, handler: nil)
    }

    // MARK: - Private

    private func makeController(withMock mock: Mock) -> RecipeLogicController {
        let networking = Networking<Endpoint>(mockProvider: MockProvider<Endpoint>(resolver: { endpoint in
            switch endpoint {
            case .recipe:
                return mock
            default:
                return nil
            }
        }))

        return RecipeLogicController(networking: networking, store: store)
    }
}
