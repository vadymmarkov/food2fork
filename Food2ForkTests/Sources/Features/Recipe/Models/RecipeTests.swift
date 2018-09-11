//
//  RecipeTests.swift
//  Food2ForkTests
//
//  Created by Markov, Vadym on 11/09/2018.
//  Copyright © 2018 FINN.no AS. All rights reserved.
//

import XCTest
@testable import Food2Fork

final class RecipeTests: XCTestCase {
    func testDecode() throws {
        let json = Recipe.makeJSONStub()
        let data = try JSONSerialization.data(withJSONObject: json, options: .prettyPrinted)
        let recipe = try JSONDecoder().decode(Recipe.self, from: data)

        XCTAssertEqual(recipe.id, json["recipe_id"] as? String)
        XCTAssertEqual(recipe.title, json["title"] as? String)
        XCTAssertEqual(recipe.imageUrl, json["image_url"] as? String)
        XCTAssertEqual(recipe.socialRank, json["social_rank"] as? Double)
        XCTAssertEqual(recipe.sourceUrl, json["source_url"] as? String)
        XCTAssertEqual(recipe.publisher, json["publisher"] as? String)
        XCTAssertEqual(recipe.publisherUrl, json["publisher_url"] as? String)
        XCTAssertEqual(recipe.ingredients, json["ingredients"] as? [String])
        XCTAssertEqual(recipe.isFavorite, false)
    }

    func testEncode() throws {
        let recipe = Recipe.makeStub(isFavorite: false)
        let data = try JSONEncoder().encode(recipe)
        let decodedRecipe = try JSONDecoder().decode(Recipe.self, from: data)

        XCTAssertEqual(recipe, decodedRecipe)
    }
}
