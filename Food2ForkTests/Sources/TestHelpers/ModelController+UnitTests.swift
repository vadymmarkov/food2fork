//
//  NetworkingFactory.swift
//  Food2ForkTests
//
//  Created by Markov, Vadym on 10/09/2018.
//  Copyright © 2018 FINN.no AS. All rights reserved.
//

import CoreData
@testable import Food2Fork

final class MockPersistentStoreContainer {
    lazy var managedObjectContext: NSManagedObjectContext = {
        let coordinator = self.persistentStoreCoordinator
        let managedObjectContext = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
        managedObjectContext.persistentStoreCoordinator = coordinator
        return managedObjectContext
    }()

    private lazy var managedObjectModel: NSManagedObjectModel = .mergedModel(from: [Bundle.main])!

    /// Redirects the `NSPersistentStoreCoordinator` to memory.
    private lazy var persistentStoreCoordinator: NSPersistentStoreCoordinator? = {
        var coordinator = NSPersistentStoreCoordinator(managedObjectModel: self.managedObjectModel)

        do {
            try coordinator.addPersistentStore(
                ofType: NSInMemoryStoreType,
                configurationName: nil,
                at: nil,
                options: nil
            )
        } catch {}

        return coordinator
    }()
}
