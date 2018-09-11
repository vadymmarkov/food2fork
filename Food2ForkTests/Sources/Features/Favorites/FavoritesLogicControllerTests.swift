//
//  FavoritesLogicControllerTests.swift
//  Food2ForkTests
//
//  Created by Vadym Markov on 10/09/2018.
//  Copyright © 2018 FINN.no AS. All rights reserved.
//

import XCTest
import Malibu
import CoreData
@testable import Food2Fork

final class FavoritesLogicControllerTests: XCTestCase {
    func testLoadWithRecipes() throws {
        let store = NSManagedObjectContext.makeStub()
        let controller = FavoritesLogicController(store: store)
        let loadExpectation = expectation(description: "load")

        try store.save(Recipe.makeStub())
        try store.save(Recipe.makeStub())

        controller.load(then: { state in
            switch state {
            case .presenting(let recipes):
                XCTAssertEqual(recipes.count, 2)
                XCTAssertEqual(recipes.filter({ $0.isFavorite }).count, 2)
                loadExpectation.fulfill()
            case .loading, .failed:
                XCTFail("Incorrect state: \(state)")
            }
        })

        waitForExpectations(timeout: 1, handler: nil)
    }

    func testLoadWithError() {
        let store = StoreMock(error: TestError.databaseError)
        let controller = FavoritesLogicController(store: store)
        let loadExpectation = expectation(description: "load")

        controller.load(then: { state in
            switch state {
            case .failed(let error):
                XCTAssertEqual(error as? TestError, TestError.databaseError)
                loadExpectation.fulfill()
            case .loading, .presenting:
                XCTFail("Incorrect state: \(state)")
            }
        })

        waitForExpectations(timeout: 1, handler: nil)
    }
}

// MARK: - Private

private enum TestError: Error {
    case databaseError
}

private final class StoreMock: ReadableStore {
    private let error: Error

    init(error: Error) {
        self.error = error
    }

    func loadObjects<T>() throws -> [T] where T: ManagedObjectInitializable {
        throw error
    }

    func loadObject<T>(predicate: NSPredicate) throws -> T? where T: ManagedObjectInitializable {
        throw error
    }
}
