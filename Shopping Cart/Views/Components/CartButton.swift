//
//  CartButton.swift
//  Shopping Cart
//
//  Created by Tendai Bandawa on 2023/03/17.
//

import SwiftUI

struct CartButton: View {
    var body: some View {
        ZStack(alignment: .topTrailing) {
            Image("icon_cart")
                .resizable()
                .scaledToFit()
                .foregroundColor(.black)
                .frame(width: 40, height: 40)
            
            Text("+9")
                .font(.caption2).bold()
                .foregroundColor(.white)
                .frame(width: 19, height: 19)
                .background(Color(hue: 1.0, saturation: 0.89, brightness: 0.835))
                .cornerRadius(50)
        }
    }
}

struct CartButton_Previews: PreviewProvider {
    static var previews: some View {
        CartButton()
    }
}
