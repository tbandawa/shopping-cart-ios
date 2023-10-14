//
//  CartStore.swift
//  Shopping Cart
//
//  Created by Tendai Bandawa on 2023/03/30.
//

import Foundation

class CartStore: ObservableObject {
    
    private let persistenceController = PersistenceController()
    
    @Published var categories: [Category] = []
    @Published var products: [Product] = []
    @Published var cartProducts: [Product] = []
    
    init() {
        categories = persistenceController.fetchCategories()
        products = persistenceController.fetchProducts(category: nil)
    }
    
    func countCartItems() -> Int {
        return Int(persistenceController.fetchCart().reduce(0) { $0 + $1.quantity })
    }
    
    func getQuantity(product: UUID) -> Int {
        return persistenceController.getQuantity(product: product)
    }
    
    func fetchProducts(category: String? = nil) {
        products = persistenceController.fetchProducts(category: category)
    }
    
    func fetchCartProducts() {
        cartProducts = persistenceController.fetchCart()
    }
    
    func addToCart(product: UUID, quantity: Int16) {
        persistenceController.addToCart(product: product, quantity: quantity)
    }
    
    func deleteFromCart(product: UUID) {
        cartProducts = persistenceController.deleteFromCart(product: product)
    }
}
