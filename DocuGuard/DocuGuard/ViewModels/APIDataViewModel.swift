//
//  APIDataViewModel.swift
//  DocuGuard
//
//  Created by Raju Singh on 21/06/25.
//

import Foundation
import CoreData

class APIDataViewModel: ObservableObject {
    private var hasFetchedFromAPI = false
    @Published var items: [CDAPIObject] = []
    @Published var errorMessage: String?
    
    let context = CoreDataManager.shared.container.viewContext
    
    func fetchFromAPI() async {
        guard !hasFetchedFromAPI else {
            print("Skipping API fetch. Already fetched once.")
            return
        }
        
        print("Fetching data from API...")
        
        guard let url = URL(string: "https://api.restful-api.dev/objects") else { return }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            
            let decoded = try JSONDecoder().decode([APIObjectResponse].self, from: data)
            print("Decoded \(decoded.count) items from API")
            
            let request: NSFetchRequest<NSFetchRequestResult> = CDAPIObject.fetchRequest()
            let deleteRequest = NSBatchDeleteRequest(fetchRequest: request)
            try context.execute(deleteRequest)
            
            for item in decoded {
                let newItem = CDAPIObject(context: context)
                newItem.id = item.id
                newItem.name = item.name
                newItem.dataDescription = item.data?.map { "\($0): \($1.value)" }.joined(separator: ", ") ?? ""
            }
            
            try context.save()
            print("Saved items to Core Data")
            
            hasFetchedFromAPI = true
            await MainActor.run {
                self.fetchFromCoreData()
            }
            
        } catch {
            await MainActor.run {
                self.errorMessage = "Failed to load: \(error.localizedDescription)"
            }
            print("API Fetch Error: \(error.localizedDescription)")
        }
    }
    
    func fetchFromCoreData() {
        let request: NSFetchRequest<CDAPIObject> = CDAPIObject.fetchRequest()
        DispatchQueue.main.async {
            self.items = (try? self.context.fetch(request)) ?? []
            print("Fetched \(self.items.count) items from Core Data")
        }
    }
    
    func delete(_ item: CDAPIObject) {
        let deletedName = item.name ?? "Unnamed Item"
        
        context.delete(item)
        try? context.save()
        fetchFromCoreData()
        
        if UserDefaults.standard.bool(forKey: "notificationsEnabled") {
            NotificationManager.shared.sendDeleteNotification(with: deletedName)
        }
    }
    
    func update(item: CDAPIObject, newName: String, newDescription: String) {
        item.name = newName
        item.dataDescription = newDescription
        do {
            try context.save()
            fetchFromCoreData()
            print("Item updated successfully")
        } catch {
            print("Failed to update item: \(error.localizedDescription)")
        }
    }
    
    func add(name: String, description: String) {
        let item = CDAPIObject(context: context)
        item.id = UUID().uuidString
        item.name = name
        item.dataDescription = description
        try? context.save()
        fetchFromCoreData()
    }
}

