//
//  SearchState.swift
//  Food2Fork
//
//  Created by Vadym Markov on 06/09/2018.
//  Copyright © 2018 FINN.no AS. All rights reserved.
//

enum SearchState {
    case loading
    case presenting([Recipe])
    case failed(Error)
}
