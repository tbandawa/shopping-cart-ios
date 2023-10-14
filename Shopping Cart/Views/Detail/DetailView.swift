//
//  DetailView.swift
//  Shopping Cart
//
//  Created by Tendai Bandawa on 2023/03/18.
//

import SwiftUI

struct DetailView: View {
    
    init(
        productId: UUID,
        title: String,
        about: String,
        image: String,
        rating: Double,
        price: Double
    ) {
        self.productId = productId
        self.title = title
        self.about = about
        self.image = image
        self.rating = rating
        self.price = price
        let appearance = UINavigationBarAppearance()
        appearance.shadowColor = .clear
        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
    }
    
    var productId: UUID
    var title: String
    var about: String
    var image: String
    var rating: Double
    var price: Double
    
    @State var itemCount = 1
    
    @EnvironmentObject var cartStore: CartStore
    
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        VStack {
            
            VStack {
                
                // MARK: Product Image
                Image(image)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 300, height: 300)
                
                // MARK: Product Details
                HStack {
                    
                    Text(title.capitalized)
                        .font(.system(size: 25, design: .rounded))
                        .foregroundColor(Color.black)
                        .fontWeight(.bold)
                    
                    Spacer()
                    
                    ZStack {
                        
                        Capsule()
                            .fill(.orange.opacity(0.2))
                            .frame(width: 73, height: 30)
                        
                        HStack {
                            
                            Image(systemName: "star.fill")
                                .foregroundColor(.orange)
                                .frame(width: 15, height: 15)
        
                            Text("\(String(format: "%.1f", rating))")
                                .font(.system(size: 16, design: .rounded))
                                .foregroundColor(.orange)
                                .fontWeight(.medium)
                            
                        }
                        
                    }
                    
                }
                .padding([.leading, .trailing])
                
                Text(about)
                    .font(.system(size: 20, design: .rounded))
                    .foregroundColor(Color.black)
                    .fontWeight(.medium)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.top, 5)
                    .padding([.leading, .trailing])
                
                Text("Cabbage, comprising several cultivars of Brassica oleracea, is a leafy green, red, or white biennial plant grown as an annual vegetable crop for its dense-leaved heads.")
                    .font(.system(size: 18, design: .rounded))
                    .foregroundColor(Color.gray)
                    .fontWeight(.regular)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.top, 5)
                    .padding([.leading, .trailing])
                
                Spacer()
                
                // MARK: Product Count
                HStack {
                    
                    Button {
                        if (itemCount > 1){
                            itemCount-=1
                        }
                    } label: {
                        Image(systemName: "minus")
                            .foregroundColor(.black)
                    }
                    .frame(width: 35, height: 35)
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(50)
                    
                    Text("\(itemCount)")
                        .font(.system(size: 30, design: .rounded))
                    
                    Button {
                        if (itemCount < 15){
                            itemCount+=1
                        }
                    } label: {
                        Image(systemName: "plus")
                            .foregroundColor(.black)
                    }
                    .frame(width: 35, height: 35)
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(50)
                        
                }
                .padding()
                
            }
            .background(.white)
            
            // MARK: Product Add To Cart
            HStack {
                
                Spacer()
                
                Text("$\(String(format: "%.2f", price))")
                    .font(.system(size: 35, design: .rounded))
                    .foregroundColor(Color.black)
                    .fontWeight(.bold)
                
                Spacer()
                
                Button("Add To Cart") {
                    cartStore.addToCart(product: productId, quantity: Int16(itemCount))
                }
                .font(.system(size: 16, weight: .bold, design: .rounded))
                .padding(10)
                .padding(.top, 0.1)
                .frame(width: 225)
                .foregroundColor(Color.white)
                .background(Color.black)
                .cornerRadius(50)
                    
            }
            .padding(.top, 15)
            .padding([.leading, .trailing, .bottom])
            
        }
        .background(Color.gray.opacity(0.1))
        .navigationBarBackButtonHidden(true)
        .navigationBarTitleDisplayMode(.inline)
        .navigationTitle("Details")
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button {
                    self.presentationMode.wrappedValue.dismiss()
                } label: {
                    Image(systemName: "arrow.left")
                        .foregroundColor(.black)
                }
            }
        }
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(
            productId: UUID(),
            title: "cabbage",
            about: "Cabbage is popular in January",
            image: "image_product_cabbage",
            rating: 4.5,
            price: 1.0
        ).environmentObject(CartStore())
    }
}
