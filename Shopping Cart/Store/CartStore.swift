//
//  CartStore.swift
//  Shopping Cart
//
//  Created by Tendai Bandawa on 2023/03/30.
//

import Foundation

class CartStore: ObservableObject {
    
    @Published var itemCount = 0
    
    func increaseItemCount() {
        self.itemCount = itemCount + 1
    }
    
    func decreaseItemCount() {
        if (self.itemCount > 0) {
            self.itemCount = itemCount - 1
        }
    }
    
}
