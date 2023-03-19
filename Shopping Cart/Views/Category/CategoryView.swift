//
//  CategoryView.swift
//  Shopping Cart
//
//  Created by Tendai Bandawa on 2023/03/19.
//

import SwiftUI

struct CategoryView: View {
    init() {
        let appearance = UINavigationBarAppearance()
        appearance.shadowColor = .clear
        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
    }
    
    var body: some View {
        NavigationView {
            ScrollView(showsIndicators: false) {
                
                
            }
            //.navigationBarTitleDisplayMode(.inline)
            .background(Color.gray.opacity(0.1))
            .navigationTitle("Vegetables")
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
                    CartButton()
                }
            }
        }
    }
}

struct CategoryView_Previews: PreviewProvider {
    static var previews: some View {
        CategoryView()
    }
}
