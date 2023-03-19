//
//  ContentView.swift
//  Shopping Cart
//
//  Created by Tendai Bandawa on 2023/03/17.
//

import SwiftUI

struct ShopView: View {
    
    init() {
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = .white
        appearance.shadowColor = .clear
        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
    }
    
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
                
                
                // MARK: Vegetables section
                VStack {
                    HStack {
                        Text("Vegetables")
                            .font(.system(size: 17, weight: .medium, design: .rounded))
                            .fontWeight(.bold)
                        Spacer()
                        Text("Show All")
                            .font(.system(size: 16, design: .rounded))
                            .foregroundColor(.orange)
                    }
                    ScrollView(.horizontal, showsIndicators: false) {
                        LazyHStack {
                            ForEach(0...5, id: \.self) { index in
                                ShopItem()
                            }
                        }
                    }
                }
                .padding(.top, 20)
                .padding(.bottom, 20)
                
                
                // MARK: Sauces section
                VStack {
                    HStack {
                        Text("Sauces")
                            .font(.system(size: 17, weight: .medium, design: .rounded))
                            .fontWeight(.bold)
                        Spacer()
                        Text("Show All")
                            .font(.system(size: 16, design: .rounded))
                            .foregroundColor(.orange)
                    }
                    ScrollView(.horizontal, showsIndicators: false) {
                        LazyHStack {
                            ForEach(0...5, id: \.self) { index in
                                ShopItem()
                            }
                        }
                    }
                }
                .padding(.top, 20)
                .padding(.bottom, 20)
                
                
                // MARK: Liquor section
                VStack {
                    HStack {
                        Text("Liquor")
                            .font(.system(size: 17, weight: .medium, design: .rounded))
                            .fontWeight(.bold)
                        Spacer()
                        Text("Show All")
                            .font(.system(size: 16, design: .rounded))
                            .foregroundColor(.orange)
                    }
                    ScrollView(.horizontal, showsIndicators: false) {
                        LazyHStack {
                            ForEach(0...5, id: \.self) { index in
                                ShopItem()
                            }
                        }
                    }
                }
                .padding(.top, 20)
                .padding(.bottom, 20)
                
                
                // MARK: Meat section
                VStack {
                    HStack {
                        Text("Meat")
                            .font(.system(size: 17, weight: .medium, design: .rounded))
                            .fontWeight(.bold)
                        Spacer()
                        Text("Show All")
                            .font(.system(size: 16, design: .rounded))
                            .foregroundColor(.orange)
                    }
                    ScrollView(.horizontal, showsIndicators: false) {
                        LazyHStack {
                            ForEach(0...5, id: \.self) { index in
                                ShopItem()
                            }
                        }
                    }                }
                .padding(.top, 20)
                .padding(.bottom, 20)
                
            }
            .navigationBarTitleDisplayMode(.inline)
            .padding([.leading, .trailing])
            .toolbar {
                CartButton()
            }
            
        }
        
    }
    
}

struct ShopView_Previews: PreviewProvider {
    static var previews: some View {
        ShopView()
    }
}
