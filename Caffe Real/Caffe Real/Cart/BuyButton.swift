//
//  BuyButton.swift
//  Caffe Real
//
//  Created by Sina Karachiani on 4/20/23.
//

import SwiftUI

struct BuyButton: View {
    @EnvironmentObject private var model: Model
    
    var body: some View {
        HStack {
            Spacer()
            Button {
                print("Pay button pressed")
                model.cart.removeAllItems()
            } label: {
                HStack {
                    Text(" Pay")
                        .font(.title2)
                        .padding(.horizontal)
                    Spacer()
                    Text(String(format: "$%.2f", model.cart.totalPrice))
                        .font(.title2)
                        .padding(.horizontal)
                }
                .padding(.vertical, 12)
                
            }
            .frame(width: Constants.cartWidth - 40)
            .buttonStyle(.plain)
            .background(.black, in: Capsule())
            
            Spacer()
        }
    }
}

struct BuyButton_Previews: PreviewProvider {
    static var previews: some View {
        BuyButton()
    }
}
