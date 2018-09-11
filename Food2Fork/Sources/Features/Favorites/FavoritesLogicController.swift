//
//  FavoritesLogicController.swift
//  Food2Fork
//
//  Created by Vadym Markov on 08/09/2018.
//  Copyright © 2018 FINN.no AS. All rights reserved.
//

import UIKit

final class FavoritesLogicController {
    typealias Handler = (ViewState<[Recipe]>) -> Void

    private let store: ReadableStore

    // MARK: - Init

    init(store: ReadableStore) {
        self.store = store
    }

    // MARK: - Logic

    func load(then handler: @escaping Handler) {
        do {
            let recipes: [Recipe] = try store.loadObjects()
            handler(.presenting(recipes))
        } catch {
            handler(.failed(error))
        }
    }
}
