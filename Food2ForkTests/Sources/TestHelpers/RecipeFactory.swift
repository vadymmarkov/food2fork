//
//  ResipeFactory.swift
//  Food2ForkTests
//
//  Created by Markov, Vadym on 10/09/2018.
//  Copyright © 2018 FINN.no AS. All rights reserved.
//

@testable import Food2Fork

final class RecipeFactory {
    static func makeRecipe() -> Recipe {
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
