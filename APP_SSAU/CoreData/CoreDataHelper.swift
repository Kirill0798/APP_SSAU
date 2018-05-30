//
//  CoreDataHelper.swift
//  APP_SSAU
//
//  Created by Кирилл Мусин on 16.04.2018.
//  Copyright © 2018 Кирилл Мусин. All rights reserved.
//

import UIKit
import CoreData

class CoreDataHelper{
    private init() {}
    
    static var context: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    static var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "SavingData")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    // MARK: - Core Data Saving support
    
    static func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
                print("SAVED")
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}
    /*class var instance: CoreDataHelper{
        struct Singleton{
            static let instance = CoreDataHelper()
        }
        return Singleton.instance
    }
    let coordinator: NSPersistentStoreCoordinator
    let model: NSManagedObjectModel
    let context: NSManagedObjectContext
    private override init() {
        let modelURL = Bundle.main.url(forResource: "Model", withExtension: "momd")!
        model = NSManagedObjectModel(contentsOf: modelURL)!
        let fileManager = FileManager.default
        let docsURL = fileManager.urls(
            for: .documentDirectory, in: .userDomainMask).last as! NSURL
        let storeURL = docsURL.appendingPathComponent("base.sqlite")
        coordinator = NSPersistentStoreCoordinator(managedObjectModel: model)
        let store = try? coordinator.addPersistentStore(
            ofType: NSSQLiteStoreType, configurationName: nil,
            at: storeURL, options: nil)
        if store == nil{
            abort()
        }
        context = NSManagedObjectContext()
        context.persistentStoreCoordinator = coordinator
        super.init()
    }
    func save() {
        var error: NSError?
        context.save(&error)
        if let error = error {
            print(error.localizedDescription)
        }
    }
    
}*/
