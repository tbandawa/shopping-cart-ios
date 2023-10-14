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
    
    func fetchProducts(category: String? = nil) {
        products = persistenceController.fetchProducts(category: category)
    }
    
    func fetchCartProducts() {
        cartProducts = persistenceController.fetchCart()
    }
    
    func addToCart(product: UUID, quantity: Int16) {
        persistenceController.addToCart(product: product, quantity: quantity)
    }
}
