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
    case search(text: String, sort: SearchSort, page: Int)
    case recipe(id: String)
}

// MARK: - Requests

extension Endpoint {
    var request: Request {
        switch self {
        case .explore:
            return Request.get("search")
        case let .search(text, sort, page):
            let parameters: [String: Any] = [
                "q": text,
                "sort": sort.rawValue,
                "page": page
            ]
            return Request.get("search", parameters: parameters)
        case let .recipe(id):
            let parameters: [String: Any] = ["rId": id]
            return Request.get("get", parameters: parameters)
        }
    }
}

// MARK: - Configuration

extension Endpoint {
    static func configure(with config: APIConfig) {
        baseUrl = config.baseUrl
        headers = ["Accept": config.acceptHeader]
    }
}
