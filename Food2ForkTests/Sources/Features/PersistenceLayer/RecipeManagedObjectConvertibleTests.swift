//
//  Recipe+ManagedObjectConvertibleTests.swift
//  Food2ForkTests
//
//  Created by Vadym Markov on 09/09/2018.
//  Copyright © 2018 FINN.no AS. All rights reserved.
//

import XCTest
import CoreData
@testable import Food2Fork

final class RecipeManagedObjectConvertibleTests: XCTestCase {
    private var persistentContainer: NSPersistentContainer!

    override func setUp() {
        super.setUp()
        persistentContainer = NSPersistentContainer(name: "Food2Fork")
        persistentContainer.loadPersistentStores(completionHandler: { _, _ in })
    }

    // MARK: - Tests

    func testInitWithManagedObject() {
        let managedObject = RecipeEntity(context: persistentContainer.viewContext)
        managedObject.uid = "123"
        managedObject.title = "Test"
        managedObject.imageUrl = "imageUrl"
        managedObject.socialRank = 100
        managedObject.sourceUrl = "sourceUrl"
        managedObject.publisher = "publisher"
        managedObject.publisherUrl = "publisherUrl"
        managedObject.ingredients = "test1;test2"
        let recipe = Recipe(managedObject: managedObject)
        XCTAssertEqual(recipe, makeRecipe())
    }

    func testToManagedObject() {
        let managedObject = makeRecipe().toManagedObject(in: persistentContainer.viewContext)
        XCTAssertEqual(managedObject.uid, "123")
        XCTAssertEqual(managedObject.title, "Test")
        XCTAssertEqual(managedObject.imageUrl, "imageUrl")
        XCTAssertEqual(managedObject.socialRank, 100)
        XCTAssertEqual(managedObject.sourceUrl, "sourceUrl")
        XCTAssertEqual(managedObject.publisher, "publisher")
        XCTAssertEqual(managedObject.publisherUrl, "publisherUrl")
        XCTAssertEqual(managedObject.ingredients, "test1;test2")
    }

    // MARK: - Helpers

    private func makeRecipe() -> Recipe {
        return Recipe(
            id: "123",
            title: "Test",
            imageUrl: "imageUrl",
            socialRank: 100,
            sourceUrl: "sourceUrl",
            publisher: "publisher",
            publisherUrl: "publisherUrl",
            ingredients: ["test1", "test2"],
            isFavorite: true
        )
    }
}
