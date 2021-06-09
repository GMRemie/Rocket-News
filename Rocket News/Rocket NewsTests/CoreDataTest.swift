//
//  CoreDataTest.swift
//  Rocket NewsTests
//
//  Created by Joseph Storer on 6/8/21.
//

import Foundation
import CoreData
import Rocket_News

class CoreDataTest{
    
    var managedObjectContext: NSManagedObjectContext?
    var coreDataHelper: CoreDataHelper?
    
    

    init() {
        
        
        let persistentStoreDescription = NSPersistentStoreDescription()
        persistentStoreDescription.type = NSInMemoryStoreType
        
        let container = NSPersistentContainer(name: "Rocket_News")
        container.persistentStoreDescriptions = [persistentStoreDescription]

        
        container.loadPersistentStores { _, error in
          if let error = error as NSError? {
            fatalError("Unresolved error \(error), \(error.userInfo)")
          }
        }
        
        coreDataHelper = CoreDataHelper(container.viewContext)
        managedObjectContext = container.viewContext
        
    }
}


