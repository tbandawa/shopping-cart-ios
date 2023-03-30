//
//  Shopping_CartApp.swift
//  Shopping Cart
//
//  Created by Tendai Bandawa on 2023/03/17.
//

import SwiftUI

@main
struct ShoppingCartApp: App {
    
    @StateObject var cartStore = CartStore()
    
    var body: some Scene {
        WindowGroup {
            ShopView()
                .environmentObject(cartStore)
        }

    }
}
