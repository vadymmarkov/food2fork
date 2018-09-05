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
