//
//  RecipeNetworkResponseTests.swift
//  Food2ForkTests
//
//  Created by Markov, Vadym on 11/09/2018.
//  Copyright © 2018 FINN.no AS. All rights reserved.
//

import XCTest
@testable import Food2Fork

final class RecipeNetworkResponseTests: XCTestCase {
    func testDecode() throws {
        let json = RecipeNetworkResponse.makeJSONStub()
        let data = try JSONSerialization.data(withJSONObject: json, options: .prettyPrinted)
        let response = try JSONDecoder().decode(RecipeNetworkResponse.self, from: data)
        let recipeJSON = json["recipe"] as? [String: Any]

        XCTAssertEqual(response.recipe.id, recipeJSON?["recipe_id"] as? String)
    }

    func testEncode() throws {
        let response = RecipeNetworkResponse(recipe: Recipe.makeStub(isFavorite: false))
        let data = try JSONEncoder().encode(response)
        let decodedResponse = try JSONDecoder().decode(RecipeNetworkResponse.self, from: data)

        XCTAssertEqual(response, decodedResponse)
    }
}

// MARK: Mocks

private extension RecipeNetworkResponse {
    static func makeJSONStub() -> [String: Any] {
        return ["recipe": Recipe.makeJSONStub()]
    }
}
