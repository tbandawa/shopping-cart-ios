//
//  DetailView.swift
//  Shopping Cart
//
//  Created by Tendai Bandawa on 2023/03/18.
//

import SwiftUI

struct DetailView: View {
    
    init() {
        let appearance = UINavigationBarAppearance()
        appearance.shadowColor = .clear
        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
    }
    
    @EnvironmentObject var cartStore: CartStore
    
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        VStack {
            
            VStack {
                
                // MARK: Product Image
                Image("cabbage")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 300, height: 300)
                
                // MARK: Product Details
                HStack {
                    
                    Text("Cabbage")
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
        
                            Text("4.5")
                                .font(.system(size: 16, design: .rounded))
                                .foregroundColor(.orange)
                                .fontWeight(.medium)
                            
                        }
                        
                    }
                    
                }
                .padding([.leading, .trailing])
                
                Text("Brassica oleracea var. capitata")
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
                        self.cartStore.itemCount = cartStore.itemCount - 1
                    } label: {
                        Image(systemName: "minus")
                            .foregroundColor(.black)
                    }
                    .frame(width: 35, height: 35)
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(50)
                    
                    Text("\(self.cartStore.itemCount)")
                        .font(.system(size: 30, design: .rounded))
                    
                    Button {
                        self.cartStore.itemCount = cartStore.itemCount + 1
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
                
                Text("$0.75")
                    .font(.system(size: 35, design: .rounded))
                    .foregroundColor(Color.black)
                    .fontWeight(.bold)
                
                Spacer()
                
                Button("Add To Cart") {
                    print("Add button was tapped")
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
        DetailView()
            .environmentObject(CartStore())
    }
}
