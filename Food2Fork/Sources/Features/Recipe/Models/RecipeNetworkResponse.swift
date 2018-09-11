//
//  RecipeNetworkResponse.swift
//  Food2Fork
//
//  Created by Vadym Markov on 05/09/2018.
//  Copyright © 2018 FINN.no AS. All rights reserved.
//

struct RecipeNetworkResponse: Codable {
    let recipe: Recipe
}

// MARK: - Equatable

extension RecipeNetworkResponse: Equatable {
    static func == (lhs: RecipeNetworkResponse, rhs: RecipeNetworkResponse) -> Bool {
        return lhs.recipe == rhs.recipe
    }
}
