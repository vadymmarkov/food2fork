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
    private weak var currentRequestPromise: Promise<RecipeNetworkResponse>?

    // MARK: - Init

    init(networking: Networking<Endpoint>) {
        self.networking = networking
    }

    // MARK: - Logic

    func load(id: String, then handler: @escaping Handler) {
        currentRequestPromise?.cancel()
        currentRequestPromise = networking
            .request(.recipe(id: id))
            .validateStatusCodes()
            .decode(RecipeNetworkResponse.self)
            .done({ response in
                handler(.presenting(response.recipe))
            })
            .fail({ error in
                handler(.failed(error))
            })
    }
}
