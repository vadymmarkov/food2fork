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

    @NSManaged public var uid: String
    @NSManaged public var title: String
    @NSManaged public var imageUrl: String
    @NSManaged public var socialRank: Double
    @NSManaged public var sourceUrl: String
    @NSManaged public var publisher: String
    @NSManaged public var publisherUrl: String
    @NSManaged public var ingredients: String?
}
