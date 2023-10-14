//
//  CheckoutView.swift
//  Shopping Cart
//
//  Created by Tendai Bandawa on 2023/03/17.
//

import SwiftUI

struct CheckoutSuccess: View {
    
    var show: Bool
    var dismissPopup: () -> Void

    var body: some View {
        ZStack {
            if show {
                // PopUp background color
                Color.black.opacity(show ? 0.3 : 0).edgesIgnoringSafeArea(.all)

                // PopUp Window
                VStack(alignment: .center, spacing: 0) {
                    
                    Image("icon_check")
                        .resizable()
                        .scaledToFit()
                        .foregroundColor(.black)
                        .frame(width: 75, height: 75)
                    
                    Text("Thanks for your order!")
                        .frame(maxWidth: .infinity)
                        .frame(height: 35, alignment: .center)
                        .font(Font.system(size: 18, weight: .semibold))
                        .foregroundColor(Color.black)

                    Text("Woohoo! Your payment was successful, and your order is complete.")
                        .multilineTextAlignment(.center)
                        .font(Font.system(size: 14, weight: .semibold))
                        .padding(EdgeInsets(top: 10, leading: 10, bottom: 20, trailing: 10))
                        .foregroundColor(Color.gray)
                    
                    Button("Continue Shopping") {
                        dismissPopup()
                    }
                    .font(.system(size: 14, weight: .bold, design: .rounded))
                    .padding(10)
                    .frame(height: 40)
                    .foregroundColor(Color.white)
                    .background(Color.black)
                    .cornerRadius(40)
                    
                }
                .frame(maxWidth: 300)
                .padding(.bottom, 20)
                .background(Color.white)
                .cornerRadius(15)
            }
        }
    }
}

struct CheckoutSuccess_Previews: PreviewProvider {
    static var previews: some View {
        CheckoutSuccess(show: true, dismissPopup: {})
    }
}
