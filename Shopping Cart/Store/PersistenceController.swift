//
//  PersistenceController.swift
//  Shopping Cart
//
//  Created by Tendai Bandawa on 2023/10/11.
//

import CoreData

struct PersistenceController {
    
    static let instance = PersistenceController()
    
    let container: NSPersistentContainer
    
    var viewContext: NSManagedObjectContext {
        return container.viewContext
    }
    
    init(inMemory: Bool = false) {
        container = NSPersistentContainer(name: "Shopping")
        if inMemory {
            container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        }
        container.loadPersistentStores{storeDescription, error in
            if let error = error as NSError? {
                print("Unresolved error \(error), \(error.userInfo)")
            }
        }
        container.viewContext.automaticallyMergesChangesFromParent = true
        loadCategories()
    }
    
    func fetchCategories() -> [Category] {
        let request: NSFetchRequest<Category> = Category.fetchRequest()
        do {
            return try self.viewContext.fetch(request)
        } catch {
            print("Error fetching categories: \(error.localizedDescription)")
            return []
        }
    }
    
    func addCategory(name: String, color: String) {
        let category = Category(context: self.viewContext)
        category.id = UUID()
        category.name = name
        category.color = color
        do {
            try self.viewContext.save()
        } catch {
            print("Failed to save data with error \(error)")
        }
    }
    
    // Initialise Categories
    private func loadCategories() {
        if (fetchCategories().isEmpty) {
            let initialCategories: KeyValuePairs<String, String> = [
                "vegetables": "color_green",
                "bakery": "color_brown",
                "dairy": "color_gray",
                "liquor": "color_yellow",
                "meat": "color_red",
                "paultry": "color_orange",
                "sauces": "color_purple"
            ]
            for cat in initialCategories {
                let category = Category(context: self.viewContext)
                category.id = UUID()
                category.name = cat.key
                category.color = cat.value
            }
            do {
                try self.viewContext.save()
            } catch {
                print("Failed to save Categories with error \(error)")
            }
        }
    }
}
