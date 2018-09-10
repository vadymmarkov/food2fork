//
//  RecipeLogicController.swift
//  Food2Fork
//
//  Created by Vadym Markov on 09/09/2018.
//  Copyright © 2018 FINN.no AS. All rights reserved.
//

import UIKit
import Malibu
import When

final class RecipeLogicController {
    typealias Handler = (ViewState<Recipe>) -> Void
    typealias Store = ReadableStore & WritableStore

    private let networking: Networking<Endpoint>
    private let store: Store
    private weak var currentRequestPromise: Promise<RecipeNetworkResponse>?

    // MARK: - Init

    init(networking: Networking<Endpoint>, store: Store) {
        self.networking = networking
        self.store = store
    }

    // MARK: - Logic

    func load(id: String, then handler: @escaping Handler) {
        let predicate = makePredicate(with: id)
        var isFavorite = false

        do {
            let object = try store.loadObject(predicate: predicate) as Recipe?
            isFavorite = object != nil
        } catch {}

        currentRequestPromise?.cancel()
        currentRequestPromise = networking
            .request(.recipe(id: id))
            .validateStatusCodes()
            .decode(RecipeNetworkResponse.self)
            .done({ response in
                var recipe = response.recipe
                recipe.isFavorite = isFavorite
                handler(.presenting(recipe))
            })
            .fail({ error in
                handler(.failed(error))
            })
    }

    func like(recipe: Recipe) throws {
        try store.save(recipe)
    }

    func unlike(recipe: Recipe) throws {
        try store.delete(Recipe.self, predicate: makePredicate(with: recipe.id))
    }

    private func makePredicate(with id: String) -> NSPredicate {
        return NSPredicate(format: "uid = %@", id)
    }
}
