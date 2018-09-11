//
//  ResipeFactory.swift
//  Food2ForkTests
//
//  Created by Markov, Vadym on 10/09/2018.
//  Copyright © 2018 FINN.no AS. All rights reserved.
//

@testable import Food2Fork

extension Recipe {
    static func makeStub(isFavorite: Bool = true) -> Recipe {
        return Recipe(
            id: "123",
            title: "Test",
            imageUrl: "imageUrl",
            socialRank: 100,
            sourceUrl: "sourceUrl",
            publisher: "publisher",
            publisherUrl: "publisherUrl",
            ingredients: ["test1", "test2"],
            isFavorite: isFavorite
        )
    }

    static func makeJSONStub() -> [String: Any] {
        return [
            "publisher": "Closet Cooking",
            "f2f_url": "https://test.com/recipe/123",
            "ingredients": [
                "ingredient 1",
                "ingredients 2"
            ],
            "source_url": "https://test.com/recipe/123",
            "recipe_id": "123",
            "image_url": "https://test.com/recipe/123/image.png",
            "social_rank": 100.0,
            "publisher_url": "https://test.com",
            "title": "Jalapeno Popper Grilled Cheese Sandwich"
        ]
    }
}
