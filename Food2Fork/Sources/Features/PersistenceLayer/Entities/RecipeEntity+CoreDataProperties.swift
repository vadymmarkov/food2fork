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

extension RecipeEntity {
    @nonobjc public class func fetchRequest() -> NSFetchRequest<RecipeEntity> {
        return NSFetchRequest<RecipeEntity>(entityName: "RecipeEntity")
    }

    @NSManaged public var id: String
    @NSManaged public var title: String
    @NSManaged public var imageUrl: String
    @NSManaged public var socialRank: Double
    @NSManaged public var sourceUrl: String
    @NSManaged public var publisher: String
    @NSManaged public var publisherUrl: String
    @NSManaged public var ingredients: String?
}
