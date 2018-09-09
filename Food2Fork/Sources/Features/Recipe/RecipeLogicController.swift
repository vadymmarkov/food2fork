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

    private let networking: Networking<Endpoint>
    private let modelController: ModelController
    private weak var currentRequestPromise: Promise<RecipeNetworkResponse>?

    // MARK: - Init

    init(networking: Networking<Endpoint>, modelController: ModelController) {
        self.networking = networking
        self.modelController = modelController
    }

    // MARK: - Logic

    func load(id: String, then handler: @escaping Handler) {
        let predicate = makePredicate(with: id)
        var isFavorite = false

        do {
            let object = try modelController.loadObject(predicate: predicate) as Recipe?
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
        try modelController.save(recipe)
    }

    func unlike(recipe: Recipe) throws {
        try modelController.delete(Recipe.self, predicate: makePredicate(with: recipe.id))
    }

    private func makePredicate(with id: String) -> NSPredicate {
        return NSPredicate(format: "uid = %@", id)
    }
}
