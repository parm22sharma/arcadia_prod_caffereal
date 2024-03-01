//
//  CartModels.swift
//  Caffe Real
//
//  Created by Sina Karachiani on 3/21/23.
//

import Foundation



struct CartItemModel: Identifiable {
    var foodItem: FoodItemModel
    var count: Int = 1
    var id : Int {return foodItem.id}
    var price: Float {return foodItem.price}
    var name: String {return foodItem.name}
    var modelName: String {return foodItem.modelName}
    
    init(foodItem: FoodItemModel, count: Int = 1) {
        self.foodItem = foodItem
        self.count = count
    }
}


struct CartModel {
    private(set) var cartItems: [CartItemModel] = []
    var totalPrice: Float = 0
    var numberOfItems: Int = 0
    
    func calculateTotalPrice() -> Float {
        var total: Float = 0
        for item in cartItems {
            total += Float(item.count) * item.price
        } 
        return total
    }
    
    mutating func removeAllItems() {
        for _ in cartItems {
            var name = cartItems[0].name
            cartItems.remove(at: 0)
            
        }
        totalPrice = 0.0
        numberOfItems = 0
    }
    
    mutating func addItem(item: FoodItemModel) {
        if cartItems.contains(where: { $0.id == item.id }){
            if let idx: Int = cartItems.firstIndex(where: { $0.id == item.id }) {
                cartItems[idx].count += 1
            }
            
        }
        else {
            cartItems.append(CartItemModel(foodItem: item, count: 1))
        }
        totalPrice += item.price
        numberOfItems += 1
    }
    
    mutating func addItem(id: Int) {
        // if already in the cart:
        if cartItems.contains(where: { $0.id == id }){
            if let idx: Int = cartItems.firstIndex(where: { $0.id == id }) {
                cartItems[idx].count += 1
                totalPrice += cartItems[idx].price
                numberOfItems += 1
            }
        }
        // else do nothing
    }
    
    
    mutating func removeItem(item: CartItemModel) {
        if cartItems.contains(where: { $0.id == item.id }){
            if let idx: Int = cartItems.firstIndex(where: { $0.id == item.id }) {
                if cartItems[idx].count > 1 {
                    cartItems[idx].count -= 1
                }
                else {
                    cartItems.remove(at: idx)
                }
                totalPrice -= item.price
                numberOfItems -= 1
            }
        } else {
            return
        }
    }
                                
                                
    mutating func removeItem(item: FoodItemModel) {
        if cartItems.contains(where: { $0.id == item.id }){
            if let idx: Int = cartItems.firstIndex(where: { $0.id == item.id }) {
                if cartItems[idx].count > 1 {
                    cartItems[idx].count -= 1
                }
                else {
                    cartItems.remove(at: idx)
                }
                totalPrice -= item.price
                numberOfItems -= 1
            }
        } else {
            return
        }
    }
    
   
    mutating func removeItem(id: Int) {
        if cartItems.contains(where: { $0.id == id }){
            if let idx: Int = cartItems.firstIndex(where: { $0.id == id }) {
                if cartItems[idx].count > 1 {
                    cartItems[idx].count -= 1
                    totalPrice -= cartItems[idx].price
                }
                else {
                    totalPrice -= cartItems[idx].price
                    cartItems.remove(at: idx)
                }
                numberOfItems -= 1
                
            }
        } else {
            return
        }
    }
}
