//
//  NSManagedObjectContextStoreTests.swift
//  Food2ForkTests
//
//  Created by Markov, Vadym on 11/09/2018.
//  Copyright © 2018 FINN.no AS. All rights reserved.
//

import XCTest
import CoreData
@testable import Food2Fork

final class NSManagedObjectContextStoreTests: XCTestCase {
    private typealias Store = ReadableStore & WritableStore
    private var store: Store!
    private let predicate = NSPredicate(format: "uid = %@", "123")

    override func setUp() {
        super.setUp()
        store = NSManagedObjectContext.makeStub()
    }

    func testLoadObjects() throws {
        var recipes = try store.loadObjects() as [Recipe]
        XCTAssertTrue(recipes.isEmpty)

        try store.save(Recipe.makeStub())
        recipes = try store.loadObjects()
        XCTAssertEqual(recipes.count, 1)
    }

    func testLoadSaveObject() throws {
        var recipe: Recipe? = try store.loadObject(predicate: predicate)
        XCTAssertNil(recipe)

        try store.save(Recipe.makeStub())
        recipe = try store.loadObject(predicate: predicate)
        XCTAssertEqual(recipe, Recipe.makeStub())
    }

    func testSave() throws {
        try store.save(Recipe.makeStub())
        let recipe: Recipe? = try store.loadObject(predicate: predicate)
        XCTAssertEqual(recipe, Recipe.makeStub())
    }

    func testDelete() throws {
        try store.save(Recipe.makeStub())
        try store.delete(Recipe.self, predicate: predicate)

        let recipe: Recipe? = try store.loadObject(predicate: predicate)
        XCTAssertNil(recipe)
    }
}
