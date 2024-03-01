//
//  MenuView.swift
//  Caffe Real
//
//  Created by Sina Karachiani on 3/2/23.
//

import SwiftUI


struct MenuView: View {
    @EnvironmentObject private var model: Model
    @State private var selectedCategory: FoodCategory = .grill
    @State private var animationOpacityValue: CGFloat = 0
    
    private var itemsToShow: [FoodItemModel] {
        switch selectedCategory {
        case FoodCategory.grill:
            return Data.grills
        case FoodCategory.desserts:
            return Data.desserts
        case FoodCategory.drinks:
            return Data.drinks
        default:
            return []
        }
    }
    
    
    var body: some View {
        
        ZStack{
            HStack {
                MenuCategoriesView(selectedCategory: $selectedCategory)
                    .rotation3DEffect(Angle(degrees: 25), axis: (x: 0, y: 1, z: 0))
                Spacer()
            }
            
            HStack{
                ForEach(itemsToShow) { item in
                    MenuItemView(id: item.id, name: item.name, modelName: item.modelName, price: item.price, description: item.description)
                        .padding()
                }
            }
            .opacity(animationOpacityValue)
            .onAppear{
                withAnimation(.easeInOut(duration: 1.5)) {
                    animationOpacityValue = 1
                }
            }
            .animation(.default)
            .frame(maxWidth: 1150)
        }        
    }
}


struct MenuCategoriesView: View {
    @Environment(\.openWindow) private var openWindow
    @Binding var selectedCategory: FoodCategory
    @EnvironmentObject private var model: Model
    @State private var isCartButtonSelected: Bool = false
    
    var body: some View {
        VStack(alignment: .leading) {
            ZStack {
                HStack{
                    Button {
    //                    if !model.isCartOpen {
    //                        openWindow(id: "cart")
    //                    }
                        withAnimation {
                            model.isCartOpen.toggle()
                        }
                        isCartButtonSelected.toggle()
                    } label: {
                        Label("Cart", systemImage: "cart.fill")
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
                    }
                    .background(isCartButtonSelected ? .white.opacity(0.1) : .clear, in: Capsule())
                    .padding(10)
                    .buttonStyle(.borderless)
                    
                }
                .frame(maxWidth: 200, alignment: .leading)
                .background(.ultraThickMaterial)
                .glassBackgroundEffect(in: RoundedRectangle(cornerSize: /*@START_MENU_TOKEN@*/CGSize(width: 20, height: 10)/*@END_MENU_TOKEN@*/))
                
                HStack{
                    Spacer()
                    Text("\(model.cart.numberOfItems)")
                        .foregroundColor(.white)
                        .font(Font.system(size: 18))
                        .bold()
                        .padding(7)
                        .background(model.cart.numberOfItems == 0 ? .gray : .red, in: Circle())
                }
                .padding(.vertical, 30)
                .offset(y: -30)
                .offset(z: 3)
                .frame(maxWidth: 200, alignment: .leading)
            }
//            .overlay(alignment: .topTrailing) {
//                Text("\(model.cart.numberOfItems)")
//                    .font(Font.system(size: 18))
//                    .foregroundColor(.white)
//                    .bold()
//                    .padding(5)
//                    .background(model.cart.numberOfItems == 0 ? .gray : .red, in: Circle())
//                    .offset(y: -20)
//                    .offset(z: 5)
//            }
    
            
            
            VStack(alignment: .leading) {
                
                MenuCategoryButton(name: FoodCategory.grill.rawValue, icon: "flame.fill", category: .grill, selectedCategory: $selectedCategory, model: model)
                MenuCategoryButton(name: FoodCategory.desserts.rawValue, icon: "birthday.cake.fill", category: .desserts, selectedCategory: $selectedCategory, model: model)
                MenuCategoryButton(name: FoodCategory.drinks.rawValue, icon: "cup.and.saucer.fill", category: .drinks, selectedCategory: $selectedCategory, model: model)
                
                VStack(alignment: .center) {
                    HStack{
                        Spacer()
                        HorizontalSeparator(length: 130)
                        Spacer()
                    }
                    Button (
                        action: {
                            print("Hide Menu pressed.")
                            if model.currentView != .home {
                                withAnimation{
                                    model.currentView = .home
                                }
                            }
                            
                        }, label: {
                            Label("Hide Menu", systemImage: "xmark.circle")
                                .font(.caption)
                        })
                    .buttonStyle(.borderless)
                    
                }
                .padding(0)
            }
            .padding(3)
            .frame(maxWidth: 200)
            .background(.ultraThickMaterial)
            .glassBackgroundEffect(in: RoundedRectangle(cornerSize: /*@START_MENU_TOKEN@*/CGSize(width: 20, height: 10)/*@END_MENU_TOKEN@*/))
        }
        
    }
}


struct MenuCategoryButton: View {
    var name: String
    var icon: String?
    var category: FoodCategory
    
    @Binding var selectedCategory: FoodCategory
    var model: Model
    fileprivate var isSelected: Bool { return name == selectedCategory.rawValue}
        
    var body: some View {
        Button {
            selectedCategory = category
            model.currentSelectionID = -1
        } label: {
            Label(name, systemImage: icon ?? "")
                .frame(maxWidth: .infinity, alignment: .leading)
        }
        .hoverEffect(/*@START_MENU_TOKEN@*/.automatic/*@END_MENU_TOKEN@*/)
        .background(isSelected ? .white.opacity(0.1) : .clear, in: Capsule())
        .padding(10)
        .buttonStyle(.borderless)
    }
}




struct MenuView_Previews: PreviewProvider {
    static var previews: some View {
        MenuView()
    }
}
