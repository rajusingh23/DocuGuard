//
//  CoreDataManager.swift
//  DocuGuard
//
//  Created by Raju Singh on 21/06/25.
//

import Foundation
import CoreData


final class CoreDataManager {
    static let shared = CoreDataManager()

    let container: NSPersistentContainer

    private init() {
        container = NSPersistentContainer(name: "UserModel") 
        container.loadPersistentStores { desc, error in
            if let error = error {
                fatalError("Failed to load Core Data: \(error)")
            }
        }
    }

    var context: NSManagedObjectContext {
        container.viewContext
    }

    func fetchUsers() -> [CDUser] {
        let request: NSFetchRequest<CDUser> = CDUser.fetchRequest()
        return (try? context.fetch(request)) ?? []
    }
    func saveUser(name: String, email: String) {
        let user = CDUser(context: context)
        user.name = name
        user.email = email

        do {
            try context.save()
            print("User saved in Core Data")
        } catch {
            print("Failed to save user: \(error)")
        }
    }

}



