//
//  Cart.swift
//  Shopping Cart
//
//  Created by Tendai Bandawa on 2023/03/17.
//

import Foundation

struct Cart: Identifiable {
    var id = UUID()
    var productId: UUID
    var quantity: Int
}
