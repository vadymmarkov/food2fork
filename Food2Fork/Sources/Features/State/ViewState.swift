//
//  ViewState.swift
//  Food2Fork
//
//  Created by Vadym Markov on 08/09/2018.
//  Copyright © 2018 FINN.no AS. All rights reserved.
//

enum ViewState<T> {
    case loading
    case presenting(T)
    case failed(Error)
}
