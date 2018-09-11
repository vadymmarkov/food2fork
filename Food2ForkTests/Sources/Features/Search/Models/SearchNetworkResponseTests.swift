//
//  SearchNetworkResponseTests.swift
//  Food2ForkTests
//
//  Created by Markov, Vadym on 11/09/2018.
//  Copyright © 2018 FINN.no AS. All rights reserved.
//

import XCTest
@testable import Food2Fork

final class SearchNetworkResponseTests: XCTestCase {
    func testDecode() throws {
        let json = SearchNetworkResponse.makeJSONStub()
        let data = try JSONSerialization.data(withJSONObject: json, options: .prettyPrinted)
        let response = try JSONDecoder().decode(SearchNetworkResponse.self, from: data)
        let recipeJSON = (json["recipes"] as? [[String: Any]])?.first

        XCTAssertEqual(response.recipes.first?.id, recipeJSON?["recipe_id"] as? String)
        XCTAssertEqual(response.count, json["count"] as? Int)
    }

    func testEncode() throws {
        let response = SearchNetworkResponse(count: 1, recipes: [Recipe.makeStub(isFavorite: false)])
        let data = try JSONEncoder().encode(response)
        let decodedResponse = try JSONDecoder().decode(SearchNetworkResponse.self, from: data)

        XCTAssertEqual(decodedResponse.count, response.count)
        XCTAssertEqual(decodedResponse.recipes, response.recipes)
    }
}

// MARK: Mocks

private extension SearchNetworkResponse {
    static func makeJSONStub() -> [String: Any] {
        return ["count": 1, "recipes": [Recipe.makeJSONStub()]]
    }
}
