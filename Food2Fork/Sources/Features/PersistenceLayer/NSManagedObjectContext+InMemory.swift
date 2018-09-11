//
//  NSManagedObjectContext+Tests.swift
//  Food2ForkTests
//
//  Created by Vadym Markov on 10/09/2018.
//  Copyright © 2018 FINN.no AS. All rights reserved.
//

import CoreData

extension NSManagedObjectContext {
    static func makeInMemoryContext() -> NSManagedObjectContext {
        let coordinator = makePersistentStoreCoordinator()
        let managedObjectContext = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
        managedObjectContext.persistentStoreCoordinator = coordinator
        return managedObjectContext
    }

    /// Redirects the `NSPersistentStoreCoordinator` to memory.
    private static func makePersistentStoreCoordinator() -> NSPersistentStoreCoordinator {
        let managedObjectModel: NSManagedObjectModel = .mergedModel(from: [Bundle.main])!
        let coordinator = NSPersistentStoreCoordinator(managedObjectModel: managedObjectModel)

        do {
            try coordinator.addPersistentStore(
                ofType: NSInMemoryStoreType,
                configurationName: nil,
                at: nil,
                options: nil
            )
        } catch {}

        return coordinator
    }
}
