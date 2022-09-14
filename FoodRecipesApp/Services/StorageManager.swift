//
//  StorageManager.swift
//  FoodRecipesApp
//
//  Created by Владимир Фалин on 13.09.2022.
//

import CoreData

protocol StorageManager: AnyObject {
    var persistentContainer: NSPersistentContainer { get set }
    func saveContext ()
}

class StorageManagerImplementation: StorageManager {
    
    // MARK: - Core Data stack
    var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "FoodRecipesApp")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support
    func saveContext () {
        let context = persistentContainer.viewContext
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



