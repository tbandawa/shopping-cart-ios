//
//  Product.swift
//  Shopping Cart
//
//  Created by Tendai Bandawa on 2023/03/17.
//

import Foundation

struct Product: Identifiable {
    var id = UUID()
    var name: String
    var synopsis: String
    var description: String
    var rating: Double
    var category: UUID
    var price: Double
}
