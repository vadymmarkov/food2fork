//
//  ImageLoaderTests.swift
//  Food2ForkTests
//
//  Created by Markov, Vadym on 11/09/2018.
//  Copyright © 2018 FINN.no AS. All rights reserved.
//

import XCTest
@testable import Food2Fork

final class ImageLoaderTests: XCTestCase {
    private var session: NetworkSessionMock!
    private var cache: CacheMock!
    private var imageLoader: ImageLoader!
    private var imageView: UIImageView!
    private let imageData = UIImagePNGRepresentation(R.image.logo()!)
    private let url = URL(string: "https://test.com/image.png")!
    private lazy var urlRequest = URLRequest(url: url)

    override func setUp() {
        super.setUp()
        session = NetworkSessionMock()
        cache = CacheMock()
        imageLoader = ImageLoader(session: session, cache: cache)
        imageView = UIImageView()
    }

    // MARK: - Tests

    func testLoadImage() {
        session.data = imageData
        session.response = HTTPURLResponse.makeStub(url: url, statusCode: 200)

        XCTAssertNil(cache.cachedResponse(for: urlRequest))

        var loadedImage: UIImage?
        imageLoader.loadImage(at: url.absoluteString, to: imageView, placeholder: nil, completion: { image in
            loadedImage = image
        })

        XCTAssertNotNil(loadedImage)
        XCTAssertEqual(loadedImage, imageView.image)
        XCTAssertNotNil(imageView.image)
        XCTAssertNotNil(cache.cachedResponse(for: urlRequest))
    }

    func testLoadImageWithInvalidResponse() {
        session.data = imageData
        session.response = HTTPURLResponse.makeStub(url: url, statusCode: 404)

        var loadedImage: UIImage?
        imageLoader.loadImage(at: url.absoluteString, to: imageView, placeholder: nil, completion: { image in
            loadedImage = image
        })

        XCTAssertNil(loadedImage)
        XCTAssertNil(imageView.image)
        XCTAssertNil(cache.cachedResponse(for: urlRequest))
    }

    func testLoadImageWithError() {
        session.data = imageData
        session.response = HTTPURLResponse.makeStub(url: url, statusCode: 200)
        session.error = TestError.invalidData

        var loadedImage: UIImage?
        imageLoader.loadImage(at: url.absoluteString, to: imageView, placeholder: nil, completion: { image in
            loadedImage = image
        })

        XCTAssertNil(loadedImage)
        XCTAssertNil(imageView.image)
        XCTAssertNil(cache.cachedResponse(for: urlRequest))
    }

    func testLoadImageWhenCached() {
        let response = HTTPURLResponse.makeStub(url: url, statusCode: 200)
        cache.storeCachedResponse(CachedURLResponse(response: response, data: imageData!), for: urlRequest)

        var loadedImage: UIImage?
        imageLoader.loadImage(at: url.absoluteString, to: imageView, placeholder: nil, completion: { image in
            loadedImage = image
        })

        XCTAssertNotNil(loadedImage)
        XCTAssertEqual(loadedImage, imageView.image)

        XCTAssertNotNil(imageView.image)
    }
}

// MARK: - Mocks

private final class NetworkSessionMock: NetworkSession {
    var data: Data?
    var response: URLResponse?
    var error: Error?

    func loadData(with request: URLRequest, completionHandler: @escaping NetworkSessionLoadCompletion) {
        completionHandler(data, response, error)
    }
}

private final class CacheMock: NetworkResponseCache {
    private var responses = [URLRequest: CachedURLResponse]()

    func cachedResponse(for request: URLRequest) -> CachedURLResponse? {
        return responses[request]
    }

    func storeCachedResponse(_ cachedResponse: CachedURLResponse, for request: URLRequest) {
        responses[request] = cachedResponse
    }
}

private enum TestError: Error {
    case invalidData
}

// MARK: - Private

private extension HTTPURLResponse {
    static func makeStub(url: URL, statusCode: Int) -> HTTPURLResponse {
        return HTTPURLResponse(url: url, statusCode: statusCode, httpVersion: "HTTP/2.0", headerFields: nil)!
    }
}
