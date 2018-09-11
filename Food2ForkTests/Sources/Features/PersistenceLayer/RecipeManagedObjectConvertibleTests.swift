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
    private var managedObjectContext: NSManagedObjectContext!

    override func setUp() {
        super.setUp()
        managedObjectContext = NSManagedObjectContext.makeStub()
    }

    // MARK: - Tests

    func testInitWithManagedObject() {
        let managedObject = RecipeEntity(context: managedObjectContext)
        managedObject.uid = "123"
        managedObject.title = "Test"
        managedObject.imageUrl = "imageUrl"
        managedObject.socialRank = 100
        managedObject.sourceUrl = "sourceUrl"
        managedObject.publisher = "publisher"
        managedObject.publisherUrl = "publisherUrl"
        managedObject.ingredients = "test1;test2"
        let recipe = Recipe(managedObject: managedObject)
        XCTAssertEqual(recipe, Recipe.makeStub())
    }

    func testToManagedObject() {
        let managedObject = Recipe.makeStub().toManagedObject(in: managedObjectContext)
        XCTAssertEqual(managedObject.uid, "123")
        XCTAssertEqual(managedObject.title, "Test")
        XCTAssertEqual(managedObject.imageUrl, "imageUrl")
        XCTAssertEqual(managedObject.socialRank, 100)
        XCTAssertEqual(managedObject.sourceUrl, "sourceUrl")
        XCTAssertEqual(managedObject.publisher, "publisher")
        XCTAssertEqual(managedObject.publisherUrl, "publisherUrl")
        XCTAssertEqual(managedObject.ingredients, "test1;test2")
    }
}
