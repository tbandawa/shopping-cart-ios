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
    @Environment(\.managedObjectContext) private var managedObjectContext
    @FetchRequest(sortDescriptors: []) private var categories: FetchedResults<Category>
    
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
                                        
                        Button(action: {}, label: {
                            HStack {
                                Image("category_vegetables")
                                    .resizable()
                                    .frame(width: 25, height: 25)
                                    .foregroundColor(.white)
                                    .clipShape(Circle())
                                Text("Vegetables")
                                    .foregroundColor(Color.white)
                                    .padding(.trailing, 5)
                            }
                        })
                        .padding(5)
                        .font(.system(size: 14, weight: .regular, design: .rounded))
                        .background(.green.opacity(0.5))
                        .cornerRadius(30)
                                        
                        Button(action: {}, label: {
                            HStack {
                                Image("category_bakery")
                                    .resizable()
                                    .frame(width: 25, height: 25)
                                    .foregroundColor(.white)
                                    .clipShape(Circle())
                                Text("Bakery")
                                    .foregroundColor(Color.white)
                                    .padding(.trailing, 5)
                            }
                        })
                        .padding(5)
                        .font(.system(size: 14, weight: .regular, design: .rounded))
                        .background(.brown.opacity(0.5))
                        .cornerRadius(30)
                                        
                        Button(action: {}, label: {
                            HStack {
                                Image("category_dairy")
                                    .resizable()
                                    .frame(width: 25, height: 25)
                                    .foregroundColor(.white)
                                    .clipShape(Circle())
                                Text("Dairy")
                                    .foregroundColor(Color.white)
                                    .padding(.trailing, 5)
                            }
                        })
                        .padding(5)
                        .font(.system(size: 14, weight: .regular, design: .rounded))
                        .background(.gray.opacity(0.5))
                        .cornerRadius(30)
                                        
                        Button(action: {}, label: {
                            HStack {
                                Image("category_liquor")
                                    .resizable()
                                    .frame(width: 25, height: 25)
                                    .foregroundColor(.white)
                                    .clipShape(Circle())
                                Text("Liquor")
                                    .foregroundColor(Color.white)
                                    .padding(.trailing, 5)
                            }
                        })
                        .padding(5)
                        .font(.system(size: 14, weight: .regular, design: .rounded))
                        .background(.yellow.opacity(0.5))
                        .cornerRadius(30)
                                        
                        Button(action: {}, label: {
                            HStack {
                                Image("category_meat")
                                    .resizable()
                                    .frame(width: 25, height: 25)
                                    .foregroundColor(.white)
                                    .clipShape(Circle())
                                Text("Meat")
                                    .foregroundColor(Color.white)
                                    .padding(.trailing, 5)
                            }
                        })
                        .padding(5)
                        .font(.system(size: 14, weight: .regular, design: .rounded))
                        .background(.red.opacity(0.5))
                        .cornerRadius(30)
                                        
                        Button(action: {}, label: {
                            HStack {
                                Image("category_paultry")
                                    .resizable()
                                    .frame(width: 25, height: 25)
                                    .foregroundColor(.white)
                                    .clipShape(Circle())
                                Text("Paultry")
                                    .foregroundColor(Color.white)
                                    .padding(.trailing, 5)
                            }
                        })
                        .padding(5)
                        .font(.system(size: 14, weight: .regular, design: .rounded))
                        .background(.orange.opacity(0.5))
                        .cornerRadius(30)
                                        
                        Button(action: {}, label: {
                            HStack {
                                Image("category_sauces")
                                    .resizable()
                                    .frame(width: 25, height: 25)
                                    .foregroundColor(.white)
                                    .clipShape(Circle())
                                Text("Sauces")
                                    .foregroundColor(Color.white)
                                    .padding(.trailing, 5)
                            }
                        })
                        .padding(5)
                        .font(.system(size: 14, weight: .regular, design: .rounded))
                        .background(.purple.opacity(0.5))
                        .cornerRadius(30)
                                        
                    }
                }
                .padding(.top, 20)
                
                // MARK: Products Grid
                LazyVGrid(columns: columns, spacing: 5) {
                    ForEach(0...14, id: \.self) { index in
                        NavigationLink(destination: DetailView()){
                            ShopItem()
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
            .onAppear {
                if (categories.count == 0) {
                    let initialCategories: KeyValuePairs<String, String> = [
                        "vegetables": "Green",
                        "bakery": "Brown",
                        "dairy": "Gray",
                        "liquor": "Yellow",
                        "meat": "Red",
                        "paultry": "Orange",
                        "sauces": "Purple"
                    ]
                    for cat in initialCategories {
                        let category = Category(context: self.managedObjectContext)
                        category.id = UUID()
                        category.name = cat.key
                        category.color = cat.value
                    }
                    do {
                        try managedObjectContext.save()
                    } catch {
                        print("Failed to save data with error \(error)")
                    }
                }
            }
        }
    }
}

struct ShopView_Previews: PreviewProvider {
    static var previews: some View {
        ShopView()
            .environmentObject(CartStore())
    }
}
