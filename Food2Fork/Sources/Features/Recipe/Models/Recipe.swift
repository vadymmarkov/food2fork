//
//  Recipe.swift
//  Food2Fork
//
//  Created by Vadym Markov on 05/09/2018.
//  Copyright © 2018 FINN.no AS. All rights reserved.
//

struct Recipe: Codable {
    enum CodingKeys: String, CodingKey {
        case id = "recipe_id"
        case title
        case imageUrl = "image_url"
        case socialRank = "social_rank"
        case sourceUrl = "source_url"
        case publisher
        case publisherUrl = "publisher_url"
        case ingredients
    }

    let id: String
    let title: String
    let imageUrl: String
    let socialRank: Double
    let sourceUrl: String
    let publisher: String
    let publisherUrl: String
    let ingredients: [String]?
}

// MARK: - Equatable

extension Recipe: Equatable {
    static func == (lhs: Recipe, rhs: Recipe) -> Bool {
        return lhs.id == rhs.id
            && lhs.title == rhs.title
            && lhs.imageUrl == rhs.imageUrl
            && lhs.socialRank == rhs.socialRank
            && lhs.sourceUrl == rhs.sourceUrl
            && lhs.publisher == rhs.publisher
            && lhs.publisherUrl == rhs.publisherUrl
            && lhs.ingredients == rhs.ingredients
    }
}
