//
//  PersistentStorage.swift
//  Currency
//
//  Created by MacBook on 29/10/2022.
//

import Foundation
import CoreData

final class PersistentStorage {

    private init () {}
    static let shared = PersistentStorage()
lazy var persistentContainer: NSPersistentContainer = {
      let container = NSPersistentContainer(name: "conversionsDataModel")
      container.loadPersistentStores { description, error in
          if let error = error {
              fatalError("Unable to load persistent stores: \(error)")
          }
      }
      return container
  }()
    
    lazy var context = persistentContainer.viewContext

func saveContext () {
    if context.hasChanges {
        do {
            try context.save()
        } catch {
            // Replace this implementation with code to handle the error appropriately.
            // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            let nserror = error as NSError
            fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
        }
    }
}
}
