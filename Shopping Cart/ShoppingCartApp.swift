//
//  Shopping_CartApp.swift
//  Shopping Cart
//
//  Created by Tendai Bandawa on 2023/03/17.
//

import SwiftUI

@main
struct ShoppingCartApp: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    var body: some Scene {
        WindowGroup {
            ShopView()
        }

    }
}
