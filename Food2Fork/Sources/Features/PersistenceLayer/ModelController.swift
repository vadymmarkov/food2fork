//
//  ModelController.swift
//  Food2Fork
//
//  Created by Vadym Markov on 09/09/2018.
//  Copyright © 2018 FINN.no AS. All rights reserved.
//

import CoreData

protocol ModelControlling {
    func loadObjects<T>() throws -> [T] where T: ManagedObjectInitializable
    func save<T>(_ object: T) throws where T: ManagedObjectConvertible
}

final class ModelController: ModelControlling {
    func loadObjects<T>() throws -> [T] where T: ManagedObjectInitializable {
        let request = T.ManagedObject.fetchRequest()
        let objects = try persistentContainer.viewContext.fetch(request) as? [T.ManagedObject] ?? []
        return objects.map({ T(managedObject: $0) })
    }

    func save<T>(_ object: T) throws where T: ManagedObjectRepresentable {
        _ = object.toManagedObject(in: persistentContainer.viewContext)
        try saveContext()
    }

    // MARK: - Core Data stack

    private lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Food2Fork")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                print("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support

    private func saveContext() throws {
        let context = persistentContainer.viewContext
        guard context.hasChanges else {
            return
        }

        do {
            try context.save()
        } catch {
            let nserror = error as NSError
            print("Unresolved error \(nserror), \(nserror.userInfo)")
            throw error
        }
    }
}
