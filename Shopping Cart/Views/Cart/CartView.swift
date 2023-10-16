//
//  CartView.swift
//  Shopping Cart
//
//  Created by Tendai Bandawa on 2023/03/17.
//

import SwiftUI
import CoreData

struct CartView: View {
    
    init() {
        let appearance = UINavigationBarAppearance()
        appearance.shadowColor = .clear
        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
    }
    
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var cartStore: CartStore
    @State private var showPopUp: Bool = false
    
    var body: some View {
        ZStack {
            
            // If cartProducts are not empty show cart otherwise show empty view
            if (!cartStore.cartProducts.isEmpty) {
                // MARK: Cart View
                VStack {
                    
                    // MARK: Cart Items
                    ScrollView {
                        ForEach(cartStore.cartProducts, id: \.self) { product in
                            CartItem(
                                productId: product.id!,
                                title: product.name!,
                                about: product.about!,
                                image: product.image!,
                                price: product.price,
                                quantity: Int16(cartStore.getQuantity(product: product.id!)),
                                removeFromcart: {
                                    cartStore.deleteFromCart(product: product.id!)
                                }
                            )
                        }
                    }
                    .background(.white)
                    .onAppear{
                        cartStore.fetchCartProducts()
                    }
                    
                    // MARK: Order Summary
                    VStack(alignment: .leading) {
                        
                        Text("Order Summary")
                            .font(.system(size: 16, design: .rounded))
                            .fontWeight(.bold)
                            .padding(.bottom, 1)
                        
                        HStack {
                            Text("Subtotal")
                            Spacer()
                            Text("$\(String(format: "%.2f", cartStore.itemsCost))")
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
                            Text("$\(String(format: "%.2f", (cartStore.itemsCost + 10.0)))")
                        }
                        .font(.system(size: 16, weight: .medium, design: .rounded))
                        .padding(.bottom, 10)
                        
                        Button("Checkout") {
                            cartStore.showPopUp = true
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
            } else {
                // MARK: Empty Cart View
                VStack(alignment: .center, spacing: 0) {
                    
                    Image("icon_empty_cart")
                        .resizable()
                        .scaledToFit()
                        .foregroundColor(.black)
                        .frame(width: 200, height: 200)
                    
                    Text("Your Cart is Empty")
                        .frame(maxWidth: .infinity)
                        .frame(height: 35, alignment: .center)
                        .font(Font.system(size: 18, weight: .semibold))
                        .foregroundColor(Color.black)

                    Text("Add Items to get Started")
                        .multilineTextAlignment(.center)
                        .font(Font.system(size: 14, weight: .semibold))
                        .padding(EdgeInsets(top: 10, leading: 10, bottom: 20, trailing: 10))
                        .foregroundColor(Color.gray)
                    
                    Button("Start Shopping") {
                        presentationMode.wrappedValue.dismiss()
                    }
                    .font(.system(size: 14, weight: .bold, design: .rounded))
                    .padding(10)
                    .frame(width: 150, height: 40)
                    .foregroundColor(Color.white)
                    .background(Color.green.opacity(0.8))
                    .cornerRadius(40)
                    
                }
                .frame(maxWidth: 300)
                .padding(.bottom, 20)
                .background(Color.white)
            }
            
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarTitleDisplayMode(.inline)
        .background(Color.gray.opacity(0.1))
        .navigationTitle("Cart")
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button {
                    presentationMode.wrappedValue.dismiss()
                } label: {
                    Image(systemName: "chevron.left")
                        .foregroundColor(.black)
                }
            }
        }
    }
}

struct CartView_Previews: PreviewProvider {
    static var previews: some View {
        CartView()
            .environmentObject(CartStore())
    }
}
