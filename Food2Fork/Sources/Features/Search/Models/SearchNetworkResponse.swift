//
//  SearchNetworkResponse.swift
//  Food2Fork
//
//  Created by Vadym Markov on 05/09/2018.
//  Copyright © 2018 FINN.no AS. All rights reserved.
//

struct SearchNetworkResponse: Codable {
    let count: Int
    let recipes: [Recipe]
}
