//
//  RecipeEntity+CoreDataProperties.swift
//  Food2Fork
//
//  Created by Vadym Markov on 09/09/2018.
//  Copyright © 2018 FINN.no AS. All rights reserved.
//
//

import Foundation
import CoreData

protocol FetchRequestCreating: NSFetchRequestResult {
    static func enityFetchRequest() -> NSFetchRequest<Self>
}

extension RecipeEntity: FetchRequestCreating {
    static func enityFetchRequest() -> NSFetchRequest<RecipeEntity> {
        return NSFetchRequest<RecipeEntity>(entityName: "RecipeEntity")
    }

    @NSManaged var uid: String
    @NSManaged var title: String
    @NSManaged var imageUrl: String
    @NSManaged var socialRank: Double
    @NSManaged var sourceUrl: String
    @NSManaged var publisher: String
    @NSManaged var publisherUrl: String
    @NSManaged var ingredients: String?
}
