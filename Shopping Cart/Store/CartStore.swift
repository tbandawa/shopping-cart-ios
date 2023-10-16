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
    @Published var showPopUp: Bool = false
    @Published var itemsCost: Double = 0.0
    
    init() {
        categories = persistenceController.fetchCategories()
        products = persistenceController.fetchProducts(category: nil)
    }
    
    /// Adds up the total number of items in cart
    /// - Returns
    ///     - Int: total number of items in cart
    func countCartItems() -> Int {
        return Int(persistenceController.fetchCart().reduce(0) { $0 + $1.quantity })
    }
    
    /// Gets quantity of Product in cart
    /// - Returns
    ///     - Int: Product quantity
    func getQuantity(product: UUID) -> Int {
        return persistenceController.getQuantity(product: product)
    }
    
    /// Retrieves products by filtering using category or return all if category == nil
    ///
    /// - Parameters
    ///     - category: product category
    func fetchProducts(category: String? = nil) {
        products = persistenceController.fetchProducts(category: category)
    }
    
    /// Fetches Cart whilts adding total cost
    func fetchCartProducts() {
        itemsCost = 0
        cartProducts = persistenceController.fetchCart()
        // For each Product, 
        for product in cartProducts {
            itemsCost += (Double(persistenceController.getQuantity(product: product.id!)) * product.price)
        }
    }
    
    /// Adds product UUID and quantity to cart
    ///
    /// - Parameters
    ///     - product: UUID for product in question
    ///     - quantity: Item quantity
    func addToCart(product: UUID, quantity: Int16) {
        persistenceController.addToCart(product: product, quantity: quantity)
    }
    
    /// Deletes a single item from cart
    /// - Parameters
    func deleteFromCart(product: UUID) {
        cartProducts = persistenceController.deleteFromCart(product: product)
        fetchCartProducts()
    }
    
    /// Deletes all items from cart
    func clearCart() {
        persistenceController.clearCart()
    }
}
