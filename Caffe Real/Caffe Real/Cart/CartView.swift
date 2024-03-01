//
//  CartView.swift
//  Caffe Real
//
//  Created by Sina Karachiani on 3/9/23.
//

import SwiftUI
import RealityKit

struct CartView: View {
    @EnvironmentObject private var model: Model
    @Environment(\.dismiss) private var dismiss
    @State var isMenuExpanded: Bool = false
    
    var body: some View {
        VStack(alignment: .center){
            MenuHeaderView(isMenuExpanded: $isMenuExpanded)
                .offset(z:77)
   
          
            VStack(alignment: .center) {
                if isMenuExpanded {
                    BuyButton()
                    .offset(z:77)
                    .transition(.move(edge: .top).combined(with: .opacity))
                    .animation(.easeInOut)
                }
                
                
                HStack {
                    Spacer()
                    HorizontalSeparator(length: Constants.cartWidth - 40)
                        .opacity(isMenuExpanded ? 1 : 0)
                        .animation(.easeInOut)
                    Spacer()
                }
                .offset(z:77)
                

                if isMenuExpanded{
                    ScrollView {
                        ForEach(model.cart.cartItems) { item in
                            CartItemView(id: item.id, name: item.name, modelName: item.modelName, price: item.price, count: item.count)
                                .padding(.vertical,0)
                                .padding(.trailing, 15)
                                .opacity(isMenuExpanded ? 1 : 0)
                                .offset(z: 75)
                                .transition(.move(edge: .bottom).combined(with: .scale))
                                .animation(.easeInOut(duration: 0.6))
                        }
                        .background(EllipticalGradient(colors: [.black.opacity(0.5), .clear]), in: RoundedRectangle(cornerRadius: 15, style: .continuous))
                            
                    }
                    .frame(maxHeight: 380)
//                    .offset(z: 100)
                    .scrollDisabled(model.cart.cartItems.count > 3 ? false : true)
                }
               
            }
            .animation(.default)
        }
        .frame(width: Constants.cartWidth)
        .frame(depth: 300)
        .onChange(of: model.isCartOpen) {
            if model.isCartOpen == false {
//                TODO: enable if use cart as a separate window
//                dismiss()
            }
        }
    }
}


struct MenuHeaderView: View {
    @Binding var isMenuExpanded: Bool
    @EnvironmentObject private var model: Model
    
    var body: some View {
//        ZStack3D(spacing: 3)
        ZStack {
            Button {
                isMenuExpanded.toggle()
            } label: {
                HStack{
                    Image(systemName: "cart.fill")
                    Spacer()
                    Image(systemName: "chevron.down")
                        .rotationEffect(isMenuExpanded ? .degrees(180) : .zero)
                        .animation(.default, value: isMenuExpanded)
                    
                }
                .font(.title)
                .bold()
                .padding(.vertical)
            }
            .buttonBorderShape(.capsule)
            .background(.thinMaterial)
            .glassBackgroundEffect(in: Capsule())
            
            HStack {
                Spacer()
                Text("\(model.cart.numberOfItems)")
                    .foregroundColor(.white)
                    .font(Font.system(size: 20))
                    .bold()
                    .padding(7)
                    .background(model.cart.numberOfItems == 0 ? .gray : .red, in: Circle())
                    
                   
            }
            .padding(.vertical, 40)
            .offset(y: -25)
            .offset(z: 3)
            .frame(height: 100)
        }
        
    }
}


struct CartItemView: View {
    var id: Int
    var name: String
    var modelName: String
    var price: Float
    var count: Int
    @State var showEditOptions: Bool = false
    @EnvironmentObject private var model: Model
    
    var body: some View {
        HStack {
            RealityView { content in
                let food = EntityContainer.cartEntities[modelName]!
                content.add(food)
            }
            .padding(0)
            .frame(width: 100, height: 100)
//            .offset(z: 75)
            
            
            HStack {
                Text("X \(count)")
                    .padding(showEditOptions ? [.trailing, .leading] : [.leading], showEditOptions ? 15 : 7)
                
                if !showEditOptions {
                    Group {
                        Spacer()
                        Text(String(format: "$%.2f", price))
                            .padding(.trailing, 7)
                    }
                    .transition(.scale.combined(with: .opacity))
                }
            }
            .padding(.vertical, showEditOptions ? 15 : 8)
            .background(.thinMaterial)
            .glassBackgroundEffect(in: Capsule())
            .onTapGesture {
                showEditOptions.toggle()
            }
            
            if showEditOptions {
                VStack {
                    Button {
                        model.cart.addItem(id: id)
                    } label: {
                        Image(systemName: "chevron.up")
                            
                    }
                    .padding(0)
                    .background(.thinMaterial)
                    .glassBackgroundEffect(in: Capsule())
                    
                    Button {
                        model.cart.removeItem(id: id)
                    } label: {
                        Image(systemName: count == 1 ? "trash.fill" : "chevron.down")
                            .padding(0)
                    }
                    .padding(0)
                    .background(.thinMaterial)
                    .glassBackgroundEffect(in: Capsule())
                }
                .frame(width: 40, height: 60)
                .transition(.scale)
            }
        }
        .frame(maxWidth: Constants.cartWidth)
    }
}




