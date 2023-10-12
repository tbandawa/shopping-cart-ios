//
//  ContentView.swift
//  Shopping Cart
//
//  Created by Tendai Bandawa on 2023/03/17.
//

import SwiftUI
import CoreData

struct ShopView: View {
    
    @EnvironmentObject private var cartStore: CartStore
    
    init() {
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = .white
        appearance.shadowColor = .clear
        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
    }
    
    var columns: [GridItem] =
                Array(repeating: .init(.flexible(), alignment: .center), count: 2)
    
    var body: some View {
        NavigationView {
            
            ScrollView(showsIndicators: false) {
                
                // MARK: - Big header
                Text("Discover our exclusive products")
                    .font(.system(size: 32, weight: .bold, design: .rounded))
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .foregroundColor(Color.black)
                
                // MARK: - Small header
                Text("In this market place, you will find various items in the cheapest price")
                    .font(.system(size: 22, weight: .medium, design: .rounded))
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .foregroundColor(Color.gray)
                    .padding(.top, 1)
                
                // MARK: Category Row
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack {
                        
                        Button(
                            action: {
                                cartStore.fetchProducts(category: nil)
                            },
                            label: {
                                HStack {
                                    Text("All Products")
                                        .frame(height: 26)
                                        .foregroundColor(Color.white)
                                        .padding(.trailing, 5)
                                }
                            }
                        )
                        .padding(5)
                        .font(.system(size: 14, weight: .regular, design: .rounded))
                        .background(.black.opacity(0.5))
                        .cornerRadius(30)
                        
                        ForEach(cartStore.categories, id: \.self) { category in
                            Button(
                                action: {
                                    cartStore.fetchProducts(category: category.name!)
                                },
                                label: {
                                    HStack {
                                        Image("image_category_\(category.name!)")
                                            .resizable()
                                            .frame(width: 25, height: 25)
                                            .foregroundColor(.white)
                                            .clipShape(Circle())
                                        Text("\(category.name!.capitalized)")
                                            .foregroundColor(Color.white)
                                            .padding(.trailing, 5)
                                    }
                                }
                            )
                            .padding(5)
                            .font(.system(size: 14, weight: .regular, design: .rounded))
                            .background(Color("\(category.color!)").opacity(0.5))
                            .cornerRadius(30)
                        }
                    }
                }
                .padding(.top, 20)
                
                // MARK: Products Grid
                LazyVGrid(columns: columns, spacing: 5) {
                    ForEach(cartStore.products, id: \.self) { product in
                        NavigationLink(
                            destination: DetailView(
                                title: product.name!,
                                about: product.about!,
                                image: product.image!,
                                rating: product.rating,
                                price: product.price
                            )
                        ){
                            ShopItem(title: product.name!, image: product.image!, rating: product.rating, price: product.price)
                        }
                    }
                }
                .padding(.top, 20)
                
            }
            .navigationBarTitleDisplayMode(.inline)
            .padding([.leading, .trailing])
            .toolbar {
                NavigationLink {
                    CartView()
                } label: {
                    CartButton(cartCount: cartStore.itemCount)
                }
                .navigationBarBackButtonHidden(true)
            }
            .navigationViewStyle(StackNavigationViewStyle())
        }
    }
}

struct ShopView_Previews: PreviewProvider {
    static var previews: some View {
        ShopView()
            .environmentObject(CartStore())
    }
}
