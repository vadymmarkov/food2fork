//
//  Promise+Decodable.swift
//  Food2Fork
//
//  Created by Vadym Markov on 05/09/2018.
//  Copyright © 2018 FINN.no AS. All rights reserved.
//

import When
import Malibu

extension Promise where T: Response {
    func validateStatusCodes() -> Promise<Response> {
        return validate(statusCodes: 200..<300)
    }

    func decode<T>(_ type: T.Type) -> Promise<T> where T: Decodable {
        return toData().then({ data in
            return try data.decoded() as T
        })
    }
}
