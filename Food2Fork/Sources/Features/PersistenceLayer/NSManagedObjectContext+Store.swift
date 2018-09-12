//
//  ModelController.swift
//  Food2Fork
//
//  Created by Vadym Markov on 09/09/2018.
//  Copyright © 2018 FINN.no AS. All rights reserved.
//

import CoreData

// MARK: - Store

protocol ReadableStore {
    func loadObjects<T>() throws -> [T] where T: ManagedObjectInitializable
    func loadObject<T>(predicate: NSPredicate) throws -> T? where T: ManagedObjectInitializable
}

protocol WritableStore {
    func save<T>(_ object: T) throws where T: ManagedObjectConvertible
    func delete<T>(_ type: T.Type, predicate: NSPredicate) throws where T: ManagedObjectInitializable
}

// MARK: - CoreData

extension NSManagedObjectContext: ReadableStore, WritableStore {
    func loadObjects<T>() throws -> [T] where T: ManagedObjectInitializable {
        let request = T.ManagedObject.enityFetchRequest()
        let objects = try fetch(request)
        return objects.map({ T(managedObject: $0) })
    }

    func loadObject<T>(predicate: NSPredicate) throws -> T? where T: ManagedObjectInitializable {
        let request = T.ManagedObject.enityFetchRequest()
        request.predicate = predicate
        let object = try fetch(request).first
        return object.map({ T(managedObject: $0) })
    }

    func save<T>(_ object: T) throws where T: ManagedObjectRepresentable {
        _ = object.toManagedObject(in: self)
        try saveContext()
    }

    func delete<T>(_ type: T.Type, predicate: NSPredicate) throws where T: ManagedObjectInitializable {
        let request = T.ManagedObject.enityFetchRequest()
        request.predicate = predicate
        if let object = try fetch(request).first {
            delete(object)
            try saveContext()
        }
    }

    // MARK: - Core Data Saving support

    private func saveContext() throws {
        guard hasChanges else {
            return
        }

        do {
            try save()
        } catch {
            let nserror = error as NSError
            print("Unresolved error \(nserror), \(nserror.userInfo)")
            throw error
        }
    }
}
