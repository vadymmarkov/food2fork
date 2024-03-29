//
//  ExploreLogicController.swift
//  Food2Fork
//
//  Created by Vadym Markov on 05/09/2018.
//  Copyright © 2018 FINN.no AS. All rights reserved.
//

import UIKit
import Malibu
import When

final class ExploreLogicController {
    typealias Handler = (ViewState<[Recipe]>) -> Void
    private typealias ExploreNetworkResponse = SearchNetworkResponse

    private let networking: Networking<Endpoint>
    private let store: ReadableStore
    private weak var currentRequestPromise: Promise<ExploreNetworkResponse>?

    // MARK: - Init

    init(networking: Networking<Endpoint>, store: ReadableStore) {
        self.networking = networking
        self.store = store
    }

    // MARK: - Logic

    func load(then handler: @escaping Handler) {
        currentRequestPromise?.cancel()
        networking
            .request(.explore)
            .validateStatusCodes()
            .decode(ExploreNetworkResponse.self)
            .done({ [weak self] response in
                let recipes = self?.makeRecipesWithFavorites(from: response.recipes) ?? []
                handler(.presenting(recipes))
            })
            .fail({ error in
                handler(.failed(error))
            })
    }

    /// Sets `isFavorite` to true for every recipe that exists in the local storage of favorite recipes.
    private func makeRecipesWithFavorites(from recipes: [Recipe]) -> [Recipe] {
        guard let entities = try? store.loadObjects() as [Recipe] else {
            return []
        }

        var recipes = recipes

        for entity in entities {
            if let index = recipes.index(where: { $0.id == entity.id }) {
                recipes[index].isFavorite = true
            }
        }

        return recipes
    }
}
