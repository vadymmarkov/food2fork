//
//  SearchLogicController.swift
//  Food2Fork
//
//  Created by Vadym Markov on 06/09/2018.
//  Copyright © 2018 FINN.no AS. All rights reserved.
//

final class SearchLogicController {
    typealias Handler = (SearchState) -> Void

    private let diskCache: DiskCache

    // MARK: - Init

    init(diskCache: DiskCache) {
        self.diskCache = diskCache
    }

    // MARK: - Logic

    func loadRecentSearches(then handler: @escaping Handler) {
        handler(.presentingRecentSearches([]))
    }
}
