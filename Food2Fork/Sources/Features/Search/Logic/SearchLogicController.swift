//
//  SearchLogicController.swift
//  Food2Fork
//
//  Created by Vadym Markov on 06/09/2018.
//  Copyright © 2018 FINN.no AS. All rights reserved.
//

import Malibu
import When

final class SearchLogicController {
    typealias Handler = (SearchState) -> Void

    private let networking: Networking<Endpoint>
    private weak var currentRequestPromise: Promise<SearchNetworkResponse>?

    // MARK: - Init

    init(networking: Networking<Endpoint>) {
        self.networking = networking
    }

    // MARK: - Logic

    func search(text: String, sort: SearchSort, page: Int, then handler: @escaping Handler) {
        currentRequestPromise?.cancel()
        currentRequestPromise = networking
            .request(.search(text: text, sort: sort, page: page))
            .validateStatusCodes()
            .decode(SearchNetworkResponse.self)
            .done({ response in
                handler(.presenting(response.recipes))
            })
            .fail({ error in
                handler(.failed(error))
            })
    }
}
