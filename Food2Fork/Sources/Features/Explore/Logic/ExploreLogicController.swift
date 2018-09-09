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
    private weak var currentRequestPromise: Promise<ExploreNetworkResponse>?

    // MARK: - Init

    init(networking: Networking<Endpoint>) {
        self.networking = networking
    }

    // MARK: - Logic

    func load(then handler: @escaping Handler) {
        currentRequestPromise?.cancel()
        networking
            .request(.explore)
            .validateStatusCodes()
            .decode(ExploreNetworkResponse.self)
            .done({ response in
                handler(.presenting(response.recipes))
            })
            .fail({ error in
                handler(.failed(error))
            })
    }
}
