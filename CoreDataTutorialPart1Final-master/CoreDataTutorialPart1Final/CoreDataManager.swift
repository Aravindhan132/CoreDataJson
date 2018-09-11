//
//  CoreDataManager.swift
//  CoreDataTutorialPart1Final
//
//  Created by aravind-pt2199 on 11/09/18.
//  Copyright © 2018 James Rochabrun. All rights reserved.
//
import Foundation
import CoreData

class CoreDataManager : NSObject {
    
    static let sharedInstance = CoreDataManager(modelName: "List")
    private let modelName: String
    init(modelName: String) {
        self.modelName = modelName
    }
     private(set) lazy var managedObjectContext: NSManagedObjectContext = {
        let managedObjectContext = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
        managedObjectContext.persistentStoreCoordinator = self.persistentStoreCoordinator
        return managedObjectContext
    }()
     private lazy var managedObjectModel: NSManagedObjectModel = {
        guard let modelURL = Bundle.main.url(forResource: self.modelName, withExtension: "momd") else {
            fatalError("Unable to Find Data Model")
        }
        guard let managedObjectModel = NSManagedObjectModel(contentsOf: modelURL) else {
            fatalError("Unable to Load Data Model")
        }
        
        return managedObjectModel
    }()
    
    
     private lazy var persistentStoreCoordinator: NSPersistentStoreCoordinator = {
        let persistentStoreCoordinator = NSPersistentStoreCoordinator(managedObjectModel: self.managedObjectModel)
        let fileManager = FileManager.default
        let storeName = "\(self.modelName).sqlite"
        let documentsDirectoryURL = fileManager.urls(for: .documentDirectory, in: .userDomainMask)[0]
        let persistentStoreURL = documentsDirectoryURL.appendingPathComponent(storeName)
        do {
            let options = [ NSInferMappingModelAutomaticallyOption : true,
                            NSMigratePersistentStoresAutomaticallyOption : true]
            
            try persistentStoreCoordinator.addPersistentStore(ofType: NSSQLiteStoreType,
                                                              configurationName: nil,
                                                              at: persistentStoreURL,
                                                              options: options)
            print(documentsDirectoryURL.path)
        } catch {
            fatalError("Unable to Load Persistent Store")
        }
        
        return persistentStoreCoordinator
    }()
    func saveContext () {
        let context = managedObjectContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}
