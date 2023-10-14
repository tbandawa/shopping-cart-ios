//
//  CartItem.swift
//  Shopping Cart
//
//  Created by Tendai Bandawa on 2023/03/17.
//

import SwiftUI

struct CartItem: View {
    
    var productId: UUID
    var title: String
    var about: String
    var image: String
    var price: Double
    var quantity: Int16
    
    var body: some View {
        HStack {
            
            Image(image)
                .resizable()
                .scaledToFit()
                .frame(width: 80, height: 80)
            
            VStack(alignment: .leading) {
                
                HStack {
                    
                    Text(title)
                        .font(.system(size: 14, design: .rounded))
                        .foregroundColor(Color.black)
                        .fontWeight(.bold)
                    
                    Spacer()
                    
                    Button {
                        print("Remove button was tapped")
                    } label: {
                        Image(systemName: "xmark")
                            .foregroundColor(.black)
                    }
                    .frame(width: 20, height: 20)
                    .cornerRadius(50)
                    
                }
                
                Text(about)
                    .font(.system(size: 12, design: .rounded))
                    .foregroundColor(Color.gray)
                
                HStack {
                    
                    Text("\(quantity)")
                        .font(.system(size: 16, design: .rounded))
                    
                    Spacer()
                    
                    Text("$\(String(format: "%.2f", price))")
                        .font(.system(size: 14, design: .rounded))
                        .fontWeight(.bold)
                }
                
            }
            .padding(.trailing, 5)
        }
        .padding()
        .frame(maxWidth: .infinity)
    }
}

struct CartItem_Previews: PreviewProvider {
    static var previews: some View {
        CartItem(
            productId: UUID(),
            title: "Cabbage",
            about: "Cabbage popular in January",
            image: "image_product_cabbage",
            price: 10.00,
            quantity: 5
        )
    }
}
