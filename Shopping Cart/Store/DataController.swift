//
//  DataController.swift
//  Shopping Cart
//
//  Created by Tendai Bandawa on 2023/10/11.
//

import Foundation
import CoreData

class DataController: ObservableObject {
    
    let container = NSPersistentContainer(name: "Shopping")
    
    init() {
        container.loadPersistentStores {description, error in
            if let error = error {
                print("Failed to load CoreData: \(error.localizedDescription)")
            }
        }
    }
}
