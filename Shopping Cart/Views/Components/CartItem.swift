//
//  CartItem.swift
//  Shopping Cart
//
//  Created by Tendai Bandawa on 2023/03/17.
//

import SwiftUI

struct CartItem: View {
    var body: some View {
        HStack {
            
            Image("image_product_cabbage")
                .resizable()
                .scaledToFit()
                .frame(width: 80, height: 80)
            
            VStack(alignment: .leading) {
                
                HStack {
                    
                    Text("Cabbage")
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
                
                Text("Brassica oleracea var. capitata")
                    .font(.system(size: 12, design: .rounded))
                    .foregroundColor(Color.gray)
                
                HStack {
                    
                    Button {
                        print("Decrease button was tapped")
                    } label: {
                        Image(systemName: "minus")
                            .foregroundColor(.black)
                    }
                    .frame(width: 20, height: 20)
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(50)
                    
                    Text("0")
                        .font(.system(size: 16, design: .rounded))
                    
                    Button {
                        print("Increase button was tapped")
                    } label: {
                        Image(systemName: "plus")
                            .foregroundColor(.black)
                    }
                    .frame(width: 20, height: 20)
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(50)
                    
                    Spacer()
                    
                    Text("$\(String(format: "%.2f", 0.75))")
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
        CartItem()
    }
}
