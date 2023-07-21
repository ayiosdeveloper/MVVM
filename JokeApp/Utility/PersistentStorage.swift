//
//  PersistentStorage.swift
//  JokeApp
//
//  Created by Ankit Yadav on 14/06/23.
//

import Foundation
import CoreData

class PersistentStorage {
    private init() {}
    static let shared = PersistentStorage()
    let bundle = Bundle(for: PersistentStorage.self)
    let model: String = "CoreData"
     lazy var persistentContainer: NSPersistentContainer = {
        guard let modelURL = bundle.url(forResource: self.model, withExtension: "momd") else {
            fatalError("❌ Loading of store failed")
        }
        
        guard let managedObjectModel =  NSManagedObjectModel(contentsOf: modelURL) else {
            fatalError("❌ Loading of store failed")
        }
        
        let container = NSPersistentContainer(name: self.model, managedObjectModel: managedObjectModel)
        container.loadPersistentStores { (storeDescription, error) in
            if let err = error {
                fatalError("❌ Loading of store failed:\(err)")
            }
        }
        
        return container
    }()
    lazy var context = persistentContainer.viewContext
    // MARK: - Core Data Saving support
    
     func saveContext() {
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    func fetch<T: NSManagedObject>(managedObject: T.Type) -> [T]? {
        do {
            guard let result = try PersistentStorage.shared.context.fetch(
                managedObject.fetchRequest()) as? [T] else { return nil }
            return result
        } catch let error {
            debugPrint(error)
        }
        return nil
    }
    
     func printDocumentDirectoryPath() {
        debugPrint(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0])
    }
    
}
