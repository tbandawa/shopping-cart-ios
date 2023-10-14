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
        loadData()
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
    
    func fetchCart() -> [Product] {
        var cartItems: [Cart] = fetchCart()
        let productIds = cartItems.map{ item in
            return item.product!
        }
        
        var cartProducts: [Product] = []
        let productsRequest: NSFetchRequest<Product> = Product.fetchRequest()
        productsRequest.predicate = NSPredicate(format: "id IN %@", productIds)
        do {
            cartProducts = try self.viewContext.fetch(productsRequest)
        } catch {
            print("Error fetching cartProducts: \(error.localizedDescription)")
            cartProducts = []
        }
        
        return cartProducts.map { addQuantity(product: $0, cart: cartItems) }
    }
    
    func deleteFromCart(product: UUID) -> [Product] {
        var cartItems: [Cart] = fetchCart()
        if let entityToDelete = cartItems.first(where: { $0.product == product }) {
            self.viewContext.delete(entityToDelete)
            saveContext()
        }
        return fetchCart()
    }
    
    func fetchProducts(category: String?) -> [Product] {
        var cartProducts: [Product] = []
        let productsRequest: NSFetchRequest<Product> = Product.fetchRequest()
        if let category = category {
            productsRequest.predicate = NSPredicate(format: "category = '\(category)'")
        }
        do {
            cartProducts = try self.viewContext.fetch(productsRequest)
        } catch {
            print("Error fetching categories: \(error.localizedDescription)")
            cartProducts = []
        }
        return cartProducts.map { addQuantity(product: $0, cart: fetchCart()) }
    }
    
    // Add product to cart
    func addToCart(product: UUID, quantity: Int16) {
        
        var savedProducts: [Cart] = []
        
        let request: NSFetchRequest<Cart> = Cart.fetchRequest()
        request.predicate = NSPredicate(format: "product = '\(product)'")
        do {
            savedProducts = try self.viewContext.fetch(request)
            if (!savedProducts.isEmpty) {
                savedProducts.first?.quantity =  quantity
                saveContext()
            }
        } catch {
            print("Error fetching categories: \(error.localizedDescription)")
        }
        
        if (savedProducts.isEmpty) {
            let cart = Cart(context: self.viewContext)
            cart.product = product
            cart.quantity = quantity
            saveContext()
        }
    }
    
    // Get all cart items
    private func fetchCart() -> [Cart] {
        let cartRequest: NSFetchRequest<Cart> = Cart.fetchRequest()
        do {
            return try self.viewContext.fetch(cartRequest)
        } catch {
            print("Error fetching cartItems: \(error.localizedDescription)")
            return []
        }
    }
    
    // Initialise Data
    private func loadData() {
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
            saveContext()
        }
        if (fetchProducts(category: nil).isEmpty) {
            let initialProducts: [[Any]] = [
                ["image_product_absolute_vodka", "Absolute Vodka", "Absolute Vodka Range Deal 750ML + Schweppes Tonic", "liquor", 5.0, 20.40, 0],
                ["image_product_apple", "Apples", "Apples 1.5kg", "vegetables", 4.5, 0.50, 0],
                ["image_product_avocado", "Avocado", "Avocado x2 per pack or 2kg 6 kg", "vegetables", 3.5, 15.50, 0],
                ["image_product_ayam_sauce_soja", "Ayam Sauce Soja", "Asian Satay Sauce 150Ml", "sauces", 3.5, 4.95, 0],
                ["image_product_baguette_bread", "Baguette Bread", "Artisan French Baguette 400 g", "bakery", 3.5, 8.60, 0],
                ["image_product_banana", "Bananas", "Bananas 2kg or 5kg 2 kg", "vegetables", 3.5, 2.99, 0],
                ["image_product_bear_brand_powdered_milk", "Bear Brand Powdered Milk", "Loya Full Cream Milk Powder 350G", "dairy", 3.5, 8.60, 0],
                ["image_product_beef", "Beef", "Beef Stew (Bone In)", "meat", 3.5, 10.90, 0],
                ["image_product_best_milk", "Best Milk", "Great Value UHT Milk Full Cream 1, L x 6", "dairy", 3.5, 1.50, 0],
                ["image_product_black_label_beer_can", "Black Label Cans", "Black Label Can - 24 x 500ml", "liquor", 3.5, 31.99, 0],
                ["image_product_bread", "Bread", "Sasko Bread Premium White 1x700g", "bakery", 3.5, 1.99, 0],
                ["image_product_cabbage", "Cabbage", "Cabbage x1(L) or 15kg Goncalves x1(L)", "vegetables", 3.5, 1.29, 0],
                ["image_product_castle_lager", "Castle Lager", "Castle Lager Beer Bottles 24 X 330ml", "liquor", 3.5, 22.00, 0],
                ["image_product_castle_lite", "Castle Lite", "Castle Lite  NRBs  (24 x 330ML)", "liquor", 4.5, 29.99, 0],
                ["image_product_cheese_cubes", "Cheese Cubes", "Cheddar cheese (White)", "dairy", 2.5, 16.40, 0],
                ["image_product_chicken_grilled", "Grilled Chicken", "Flame Grilled Sticky BBQ Chicken Mini Fillets 250 g", "paultry", 3.8, 10.89, 0],
                ["image_product_chicken_thighs", "Chicken Thighs", "Chicken Thighs 600g", "paultry", 2.9, 3.95, 0],
                ["image_product_chipotle_hot_sauce", "Chipotle Hot Sauce", "Chipotle Pepper Hot Sauce - 7oz Bottle - Made in USA with Jalapeno & C", "sauces", 3.9, 4.00, 0],
                ["image_product_cream_doughnuts", "Cream Doughnuts", "Glazed Doughnuts", "bakery", 4.5, 0.50, 0],
                ["image_product_curry_ketchup", "Cream Doughnuts", "Spice Curry Ketchup, Old Spice Office bottle", "sauces", 4.5, 25.75, 0],
                ["image_product_eggs", "Cream Doughnuts", "Msenge XL Eggs (30)", "paultry", 5.0, 7.05, 0],
                ["image_product_fresh_chicken", "Butchery Fresh Whole Chicken", "Msenge XL Eggs (30)", "paultry", 4.3, 9.99, 0],
                ["image_product_garlic_steak", "Garlic Steak", "Plankie Steak Garlic Sauce 500ml", "sauces", 4.0, 14.50, 0],
                ["image_product_goat_meat", "Goat Meat", "Goat Meat (6 Pcs)", "meat", 3.5, 8.30, 0],
                ["image_product_grapes", "Grapes", "Black Grapes 500g; 2kg and 4kg 500 g", "vegetables", 4.5, 4.49, 0],
                ["image_product_hot_sauce", "Hot Sauce", "Shop Valentina Hot Salsa - 370ml - Ark Provisions", "sauces", 4.7, 10.00, 0],
                ["image_product_instant_dry_milk", "Instant Dry Milk", "First Choice-Full Cream Milk Powder 2 x 500g", "dairy", 3.2, 16.90, 0],
                ["image_product_nestle_nido", "Nestle Nido", "Nestle Nido Instant Full Cream Milk Powder 900g", "dairy", 4.2, 22.56, 0],
                ["image_product_orange", "Oranges", "Oranges 3 kg, 7 kg and 10 kg 3 kg", "vegetables", 3.9, 2.99, 0],
                ["image_product_parmigiano_reggiano_gruyere_cheese", "Parmigiano Reggiano Gruyere Cheese", "Parmesan (Parmesano Reggiano) hard grating cheese", "dairy", 4.1, 45.79, 0],
                ["image_product_pink_scoop_cake", "Cake", "Cake Scoop 32 cm", "bakery", 3.9, 32.45, 0],
                ["image_product_scone_cream_biscuits", "Cream Scones", "Cream Scones box of 4", "bakery", 2.9, 9.48, 0],
                ["image_product_sliced_raw_pork", "Sliced Raw Pork", "Pork Rashers Plain / 4kg", "meat", 4.0, 41.99, 0],
                ["image_product_smirnoff", "Smirnoff", "Smirnoff 1818 Vodka (1 x 750ml)", "liquor", 5.0, 15.80, 0],
                ["image_product_soya_milk_powder", "Soya Milk Powder", "Cape Creamy Soya Milk Powder 1kg", "dairy", 4.2, 13.99, 0],
                ["image_product_tomato_ketchup", "Tomato Ketchup", "Heinz Organic Tomato Ketchup, 580 g", "sauces", 4.8, 6.50, 0]
            ]
            for prod in initialProducts {
                let product = Product(context: self.viewContext)
                product.id = UUID()
                product.image = String(describing: prod[0])
                product.name = String(describing: prod[1])
                product.about = String(describing: prod[2])
                product.category = String(describing: prod[3])
                product.rating = prod[4] as! Double
                product.price = prod[5] as! Double
                product.quantity = prod[6] as! Int16
            }
            saveContext()
        }
    }
    
    // Get product quantity from cartItems
    private func addQuantity(product: Product, cart: [Cart]) -> Product {
        if let quantity = cart.first(where: { $0.product == product.id })?.quantity {
            product.quantity = quantity
        }
        return product
    }
    
    // Save objects in context
    private func saveContext() {
        do {
            try self.viewContext.save()
        } catch {
            print("Failed to save data with error \(error)")
        }
    }
}
