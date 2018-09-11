//
//  PromiseNetworkingTests.swift
//  Food2ForkTests
//
//  Created by Markov, Vadym on 11/09/2018.
//  Copyright © 2018 FINN.no AS. All rights reserved.
//

import XCTest
import Malibu
import When
@testable import Food2Fork

final class PromiseNetworkingTests: XCTestCase {
    func testValidateStatusCodes() throws {
        let failPromise = Promise<Response>()
        let failExpectation = expectation(description: "fail")

        failPromise.validateStatusCodes().fail { error in
            failExpectation.fulfill()
        }
        failPromise.resolve(Response.makeStub(statusCode: 404))

        let successPromise = Promise<Response>()
        let successExpectation = expectation(description: "success")

        successPromise.validateStatusCodes().done { _ in
            successExpectation.fulfill()
        }
        successPromise.resolve(Response.makeStub(statusCode: 200))

        waitForExpectations(timeout: 1, handler: nil)
    }

    func testDecode() throws {
        let promise = Promise<Response>()
        let data = try JSONEncoder().encode(Recipe.makeStub())
        let decodeExpectation = expectation(description: "fail")

        promise.decode(Recipe.self).done { recipe in
            decodeExpectation.fulfill()
        }
        promise.resolve(Response.makeStub(statusCode: 200, data: data))

        waitForExpectations(timeout: 1, handler: nil)
    }
}

// MARK: - Mocks

private extension Response {
    static func makeStub(statusCode: Int, data: Data = Data()) -> Response {
        let url = URL(string: "https://test.com")!
        let httpResponse = HTTPURLResponse(
            url: url,
            statusCode: statusCode,
            httpVersion: "HTTP/2.0",
            headerFields: nil
        )!

        return Response(data: data, urlRequest: URLRequest(url: url), httpUrlResponse: httpResponse)
    }
}
