//
//  CartButton.swift
//  Shopping Cart
//
//  Created by Tendai Bandawa on 2023/03/17.
//

import SwiftUI

struct CartButton: View {
    
    var cartCount: Int
    
    var body: some View {
        ZStack(alignment: .topTrailing) {
            Image("icon_cart")
                .resizable()
                .scaledToFit()
                .foregroundColor(.black)
                .frame(width: 35, height: 35)
            
            Text("\(cartCount)")
                .font(.caption2).bold()
                .foregroundColor(.white)
                .frame(width: 19, height: 19)
                .background(.black)
                .cornerRadius(50)
        }
    }
}

struct CartButton_Previews: PreviewProvider {
    static var previews: some View {
        CartButton(cartCount: 0)
    }
}
