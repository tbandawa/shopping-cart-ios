//
//  CartStore.swift
//  Shopping Cart
//
//  Created by Tendai Bandawa on 2023/03/30.
//

import Foundation

class CartStore: ObservableObject {
    
    private let persistenceController = PersistenceController()
    
    init() {
        let results = persistenceController.fetchCategories()
        print("Category results = \(results.count)")
    }
    
    @Published var itemCount = 0
    
    func increaseItemCount() {
        self.itemCount = itemCount + 1
    }
    
    func decreaseItemCount() {
        if (self.itemCount > 0) {
            self.itemCount = itemCount - 1
        }
    }
    
    func addItem() {
        persistenceController.addCategory(name: "naem", color: "color")
    }
    
    func getItem() {
        let results = persistenceController.fetchCategories()
        print("Category results = \(results.count)")
    }
}
