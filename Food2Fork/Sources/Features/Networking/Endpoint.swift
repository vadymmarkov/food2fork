//
//  Endpoint.swift
//  Food2Fork
//
//  Created by Markov, Vadym on 05/09/2018.
//  Copyright © 2018 FINN.no AS. All rights reserved.
//

import Malibu

// MARK: - Endpoints

enum Endpoint: RequestConvertible {
    static var baseUrl: URLStringConvertible?
    static var headers: [String: String] = [:]

    case explore
    case search(text: String)
    case recipe(id: Int)
}

// MARK: - Requests

extension Endpoint {
    var request: Request {
        switch self {
        case .explore:
            return Request.get("search")
        case .search(let text):
            return Request.get("search")
        case .recipe(let id):
            return Request.get("")
        }
    }
}
