//
//  ManagedObjectConvertible.swift
//  Food2Fork
//
//  Created by Vadym Markov on 09/09/2018.
//  Copyright © 2018 FINN.no AS. All rights reserved.
//

import CoreData

typealias ManagedObjectConvertible = ManagedObjectInitializable & ManagedObjectRepresentable

protocol ManagedObjectInitializable {
    associatedtype ManagedObject: NSManagedObject & FetchRequestCreating
    init(managedObject: ManagedObject)
}

protocol ManagedObjectRepresentable {
    associatedtype ManagedObject: NSManagedObject & FetchRequestCreating
    func toManagedObject(in context: NSManagedObjectContext) -> ManagedObject
}
