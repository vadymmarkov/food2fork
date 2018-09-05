//
//  ExploreLogicController.swift
//  Food2Fork
//
//  Created by Vadym Markov on 05/09/2018.
//  Copyright © 2018 FINN.no AS. All rights reserved.
//

import UIKit
import Malibu

final class ExploreLogicController {
    typealias Handler = (ExploreState) -> Void
    private typealias ExploreNetworkResponse = SearchNetworkResponse

    private let networking: Networking<Endpoint>
    private weak var currentRequestPromise: NetworkPromise?

    // MARK: - Init

    init(networking: Networking<Endpoint>) {
        self.networking = networking
    }

    // MARK: - Logic

    func load(then handler: @escaping Handler) {
        currentRequestPromise?.cancel()
        currentRequestPromise = networking.request(.explore).validateStatusCodes()
        currentRequestPromise?
            .decode(ExploreNetworkResponse.self)
            .done({ response in
                handler(.presenting(response.recipes))
            })
            .fail({ error in
                handler(.failed(error))
            })
    }
}
