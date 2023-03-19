//
//  CartView.swift
//  Shopping Cart
//
//  Created by Tendai Bandawa on 2023/03/17.
//

import SwiftUI

struct CartView: View {
    
    init() {
        let appearance = UINavigationBarAppearance()
        appearance.shadowColor = .clear
        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
    }
    
    var body: some View {
        NavigationView {
            ZStack {
                
                // MARK: Cart View
                VStack {
                    
                    // MARK: Cart Items
                    ScrollView {
                        CartItem()
                        CartItem()
                        CartItem()
                        CartItem()
                        CartItem()
                        CartItem()
                    }
                    .background(.white)
                    
                    // MARK: Order Summary
                    VStack(alignment: .leading) {
                        
                        Text("Order Summary")
                            .font(.system(size: 16, design: .rounded))
                            .fontWeight(.bold)
                            .padding(.bottom, 1)
                        
                        HStack {
                            Text("Subtotal")
                            Spacer()
                            Text("$100.00")
                        }
                        .font(.system(size: 14, design: .rounded))
                        .padding(.bottom, 1)
                        
                        HStack {
                            Text("Tax")
                            Spacer()
                            Text("$10.00")
                        }
                        .font(.system(size: 14, design: .rounded))
                        .padding(.bottom, 1)
                        
                        HStack {
                            Text("Total")
                            Spacer()
                            Text("$120.00")
                        }
                        .font(.system(size: 16, weight: .medium, design: .rounded))
                        .padding(.bottom, 10)
                        
                        Button("Checkout") {
                            print("Checkout button was tapped")
                        }
                        .font(.system(size: 16, weight: .bold, design: .rounded))
                        .padding(10)
                        .padding(.top, 0.1)
                        .frame(maxWidth: .infinity)
                        .foregroundColor(Color.white)
                        .background(Color.black)
                        .cornerRadius(50)
                        .frame(maxWidth: .infinity, alignment: .center)
                            
                    }
                    .padding(.top, 5)
                    .padding([.leading, .trailing, .bottom])
                    
                }
                
            }
            .navigationBarTitleDisplayMode(.inline)
            .background(Color.gray.opacity(0.1))
            .navigationTitle("Cart")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        print("Edit back was tapped")
                    } label: {
                        Image(systemName: "chevron.left")
                            .foregroundColor(.black)
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        print("Clear button was tapped")
                    } label: {
                        Image(systemName: "xmark.bin")
                            .foregroundColor(.black)
                    }
                }
            }
        }
    }
}

struct CartView_Previews: PreviewProvider {
    static var previews: some View {
        CartView()
    }
}
