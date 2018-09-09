//
//  Recipe+ManagedObjectConvertible.swift
//  Food2Fork
//
//  Created by Vadym Markov on 09/09/2018.
//  Copyright © 2018 FINN.no AS. All rights reserved.
//

import CoreData

extension Recipe: ManagedObjectConvertible {
    private static let separator: String = ";"

    init(managedObject: RecipeEntity) {
        self.init(
            id: managedObject.uid,
            title: managedObject.title,
            imageUrl: managedObject.imageUrl,
            socialRank: managedObject.socialRank,
            sourceUrl: managedObject.sourceUrl,
            publisher: managedObject.publisher,
            publisherUrl: managedObject.publisherUrl,
            ingredients: managedObject.ingredients?.components(separatedBy: Recipe.separator),
            isFavorite: true
        )
    }

    func toManagedObject(in context: NSManagedObjectContext) -> RecipeEntity {
        let managedObject = RecipeEntity(context: context)
        managedObject.uid = id
        managedObject.title = title
        managedObject.imageUrl = imageUrl
        managedObject.socialRank = socialRank
        managedObject.sourceUrl = sourceUrl
        managedObject.publisher = publisher
        managedObject.publisherUrl = publisherUrl
        managedObject.ingredients = ingredients?.joined(separator: Recipe.separator)
        return managedObject
    }
}
