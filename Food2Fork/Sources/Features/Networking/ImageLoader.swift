//
//  ImageLoader.swift
//  Food2Fork
//
//  Created by Vadym Markov on 05/09/2018.
//  Copyright © 2018 FINN.no AS. All rights reserved.
//

import UIKit

final class ImageLoader {
    private let urlSession: URLSession
    private let urlCache: URLCache
    private let decompressor = ImageDecompressor()

    init(urlSession: URLSession = .shared, urlCache: URLCache = .shared) {
        self.urlSession = urlSession
        self.urlCache = urlCache
    }

    /// Loads image from web asynchronosly and caches it
    func loadImage(at urlString: String, to imageView: UIImageView, placeholder: UIImage? = nil) {
        guard let imageUrl = URL(string: urlString) else {
            return
        }

        let request = URLRequest(url: imageUrl)

        if let data = urlCache.cachedResponse(for: request)?.data, let image = decompressor.decompress(data: data) {
            imageView.image = image
        } else {
            imageView.image = placeholder
            loadAndCacheImage(to: imageView, using: request)
        }
    }

    private func loadAndCacheImage(to imageView: UIImageView, using request: URLRequest) {
        urlSession.dataTask(with: request, completionHandler: { [weak self] data, response, error in
            guard let response = response as? HTTPURLResponse, response.statusCode < 300 else {
                return
            }

            guard let data = data, let image = self?.decompressor.decompress(data: data) else {
                return
            }

            let cachedData = CachedURLResponse(response: response, data: data)
            self?.urlCache.storeCachedResponse(cachedData, for: request)

            DispatchQueue.main.async { [weak imageView] in
                imageView?.image = image
            }
        }).resume()
    }
}

// MARK: - Decompressor

private final class ImageDecompressor {
    func decompress(data: Data) -> UIImage? {
        guard let image = UIImage(data: data) else {
            return nil
        }

        guard let imageRef = image.cgImage, let colorSpaceRef = imageRef.colorSpace else {
            return image
        }

        if imageRef.alphaInfo != .none {
            return image
        }

        let width = imageRef.width
        let height = imageRef.height
        let bytesPerPixel: Int = 4
        let bytesPerRow: Int = bytesPerPixel * width
        let bitsPerComponent: Int = 8
        let context = CGContext(
            data: nil,
            width: width,
            height: height,
            bitsPerComponent: bitsPerComponent,
            bytesPerRow: bytesPerRow,
            space: colorSpaceRef,
            bitmapInfo: CGBitmapInfo().rawValue
        )

        context?.draw(imageRef, in: CGRect(x: 0, y: 0, width: CGFloat(width), height: CGFloat(height)))

        guard let imageRefWithoutAlpha = context?.makeImage() else {
            return image
        }

        return UIImage(cgImage: imageRefWithoutAlpha)
    }
}
