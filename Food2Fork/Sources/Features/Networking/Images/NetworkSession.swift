//
//  NetworkSession.swift
//  Food2Fork
//
//  Created by Markov, Vadym on 11/09/2018.
//  Copyright © 2018 FINN.no AS. All rights reserved.
//

import Foundation

typealias NetworkSessionLoadCompletion = (Data?, URLResponse?, Error?) -> Void

protocol NetworkSession {
    func loadData(with request: URLRequest, completionHandler: @escaping NetworkSessionLoadCompletion)
}

// MARK: - URLSession

extension URLSession: NetworkSession {
    func loadData(with request: URLRequest, completionHandler: @escaping NetworkSessionLoadCompletion) {
        let task = dataTask(with: request, completionHandler: { (data, response, error) in
            completionHandler(data, response, error)
        })

        task.resume()
    }
}
