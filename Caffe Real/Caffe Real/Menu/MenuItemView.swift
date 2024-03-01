//
//  MenuItemView.swift
//  Caffe Real
//
//  Created by Sina Karachiani on 3/2/23.
//

import SwiftUI
import RealityKit

struct MenuItemView: View {
    @EnvironmentObject private var model: Model

    var id: Int
    var name: String
    var modelName: String
    var price: Float
    var description: String
    private var isSelected: Bool { return model.currentSelectionID == self.id}

    var body: some View {
        VStack {
            Spacer()
            RealityView { content in
                content.add(EntityContainer.entities[modelName]!)
            }
            .frame(width: 150, height: 100)
            .shadow(radius: 80)
            .padding([.horizontal],0)
            .padding([.top], 20)
            .padding([.bottom], 40)
            .scaleEffect(isSelected ? 1.3 : 0.9)
            .offset()
            .onChange(of: isSelected) { _, _ in
                EntityContainer.entities[modelName]!.setSpinSpeed(speed: isSelected ? 0.3 : 0)
                if isSelected {
                    EntityContainer.entities[modelName]?.enableParticleEmission()
                } else {
                    EntityContainer.entities[modelName]!.setOrientation(simd_quatf(ix: 0, iy: 0, iz: 0, r: 0), relativeTo: nil)
                    EntityContainer.entities[modelName]?.disableParticleEmission()
                }
            }
            
            MenuItemCaptionView(id: id, name: name, price: price, modelName: modelName)
                .rotation3DEffect(Angle(degrees: 12), axis: (x: 1, y: 0, z: 0))
                .offset(z: 95)
                .padding(.bottom, 25)
                .padding(.top, 10)
            
                
            if isSelected {
                MenuItemDescriptionView(description: description)
                    .offset(z: 100)
                    .padding([.bottom], 50)
                    .transition(.opacity.combined(with: .scale))
            }
        }
        .offset(y: isSelected ? 40 : 0)
        .offset(z: isSelected ? 50 : 0)
    }
}


struct MenuItemCaptionView: View {
    @EnvironmentObject private var model: Model
    
    @State private var isPressed = false
    @State private var isAddPressed = false
    
    var  id: Int
    var name: String
    var price: Float
    var modelName: String
    private var isSelected: Bool { return model.currentSelectionID == self.id}
    @State private var animationScaleValue: CGFloat = 0
    @State private var animationScaleValue2: CGFloat = 1
    
    var body: some View {
        HStack{
            Button {
                if isSelected {
                    model.currentView = .menu
                    model.currentSelectionID = -1
//                    EntityContainer.entities[modelName]?.disableParticleEmission()
                    
                } else {
                    model.currentView = .foodDetails
                    model.currentSelectionID = id
//                    EntityContainer.entities[modelName]?.enableParticleEmission()
                }
            } label: {
                HStack(spacing: 5){
                    Text(name)
                        .font(.title3)
//                        .italic()
                        .foregroundColor(.white)
                        .shadow(color: .black.opacity(0.8), radius: 5, x: 0, y: 5)
                        .padding(isSelected ? [.vertical, .leading] : [.all])
                    
                    
                    if isSelected {
                        verticalSeparator()
                        
                        Text(String(format: "$%.2f", price))
                            .font(.title3)
//                            .italic()
                            .foregroundColor(.white)
                            .shadow(color: .black.opacity(0.8), radius: 5, x: 0, y: 5)
                            .padding(.trailing)
                    }
                }
            }
            .background(.thinMaterial.shadow(.drop(radius: 10)))
            .glassBackgroundEffect(in: Capsule())
            .scaleEffect(animationScaleValue2)
            .simultaneousGesture(
                DragGesture(minimumDistance: 0)
                    .onChanged({_ in
                        withAnimation(.linear) {
                            animationScaleValue2 = 0.8
                        }
                    })
                    .onEnded({_ in
                        withAnimation(.linear) {
                            animationScaleValue2 = 1
                        }
                    })
            )
            
            // MARK: Add (+) Button
            if isSelected {
                Button() {
                    print("added to the cart")
                    model.cart.addItem(item: Data.foodItems[id])
                    print("\(model.cart.cartItems.count)")
                    
                } label: {
                    Image(systemName: "plus")
                        .font(.title)
                        .shadow(color: .black.opacity(0.7), radius: 5, x: 0, y: 5)
                        .padding()
                }
                .buttonBorderShape(.circle)
                .background(.thinMaterial)
                .glassBackgroundEffect(in: Circle())
                .scaleEffect(isAddPressed ? 2*animationScaleValue : animationScaleValue)
                .transition(
                    AsymmetricTransition(
                        insertion: .move(edge: .leading).combined(with: .scale),
                        removal: .move(edge: .leading).combined(with: .opacity))
                )
                .animation(.interpolatingSpring(duration: 0.5, bounce: 5, initialVelocity: 5), value:animationScaleValue)
                .onAppear {
                    animationScaleValue = 1.0
                }
                .onDisappear {
                    animationScaleValue = 0.0
                }
                .simultaneousGesture(
                    DragGesture(minimumDistance: 0)
                        .onChanged({_ in
                            withAnimation(.linear) {
                                animationScaleValue = 0.8
                            }
                        })
                        .onEnded({_ in
                            withAnimation(.interpolatingSpring(duration: 1, bounce: 10, initialVelocity: 15)) {
                                animationScaleValue = 1
                            }
                        })
                )
            }
        }
    }
}

struct MenuItemDescriptionView: View {
    var description: String
    
    var body: some View {
        Text(description)
            .foregroundColor(.white)
            .font(.system(size: 18))
            .italic()
            .multilineTextAlignment(.center)
            .lineLimit(3)
            .shadow(color: .black, radius: 5, x: 4, y: 8)
//            .castsShadows(true)
            .frame(maxWidth: 400)
            .padding()
            .background(Color.gray.opacity(0), in: RoundedRectangle(cornerRadius: 15, style: .circular))
    }
}





//struct MenuItemView_Previews: PreviewProvider {
//    static var previews: some View {
//        MenuItemView(name: "Cheese Burger", modelName: "Cheeseburger")
//    }
//}

//
