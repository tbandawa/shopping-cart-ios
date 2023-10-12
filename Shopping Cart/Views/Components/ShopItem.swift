//
//  ItemView.swift
//  Shopping Cart
//
//  Created by Tendai Bandawa on 2023/03/17.
//

import SwiftUI

struct ShopItem: View {
    
    var title: String
    var image: String
    var rating: Double
    var price: Double
    
    var body: some View {
        ZStack(alignment: .topTrailing) {
            
            VStack {
                
                Image(image)
                    .resizable()
                    .cornerRadius(20)
                    .frame(width: 170, height: 170)
                    .scaledToFit()
                
                Text(title.capitalized)
                    .font(.system(size: 14, design: .rounded))
                    .foregroundColor(Color.black)
                    .fontWeight(.bold)
                    .padding(.leading, 5)
                    .padding(.trailing, 5)
                
                HStack {
                    
                    Text("$\(price)")
                        .font(.system(size: 14, design: .rounded))
                        .fontWeight(.bold)
                    
                    Spacer()
                    
                    ZStack {
                        
                        Capsule()
                            .fill(.orange.opacity(0.2))
                            .frame(width: 25, height: 15)
                        
                        HStack {
                            
                            Text("\(rating)")
                                .font(.system(size: 10, design: .rounded))
                                .foregroundColor(.orange)
                                .fontWeight(.medium)
                            
                        }
                        
                    }
                }
                .padding(.top, 2)
                .padding(.leading, 8)
                .padding(.trailing, 8)
                
            }
            .frame(width: 185, height: 240)
            
            Text("+9")
                .font(.caption2).bold()
                .foregroundColor(.white)
                .frame(width: 21, height: 21)
                .background(Color(hue: 1.0, saturation: 0.89, brightness: 0.835))
                .cornerRadius(50)
                .padding(.top, 7)
                .padding(.trailing, 7)
            
        }
        .background(.gray.opacity(0.2))
        .cornerRadius(5)
        .padding(.top, 10)
    }
}

struct ShopItem_Previews: PreviewProvider {
    static var previews: some View {
        ShopItem(title: "Cabbage", image: "image_product_cabbage", rating: 4.5, price: 1.00)
    }
}
