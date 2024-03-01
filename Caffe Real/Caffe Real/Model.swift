//
//  Model.swift
//  Caffe Real
//
//  Created by Sina Karachiani on 3/2/23.
//
import RealityKit
import Foundation
import CafeRealMatadorPackage

public enum ViewState {
    case home, menu, foodDetails
}

public enum FoodCategory: String {
    case drinks = "Drinks"
    case desserts = "Desserts"
    case grill = "Grill"
    case food = "Food"
    case fruits = "Fruits"
}


struct EntityContainer {
    static var entities: [String : Entity] = [:]
    static var cartEntities: [String : Entity] = [:]
    static var matadorScene: Entity = try! Entity.load(named: "Scene.usda", in: CafeRealMatadorPackage.cafeRealMatadorPackageBundle)
    
    static func load3DModels() {
        for item in Data.foodItems {
            if item.category == FoodCategory.grill { // if grill item, load from Matador scene to have the smoke effect
                let food = matadorScene.children.first?.children.first(where: { entity in
                    print("Grill: \(entity.name)")
                    return entity.name == item.modelName
                })
                
                food?.createSpinComponent()
                food?.disableParticleEmission()
                food?.setPosition(.zero, relativeTo: nil)
                food?.scale *= 0.1 / (food?.visualBounds(relativeTo: nil).boundingRadius)!
                food?.position -= (food?.visualBounds(relativeTo: nil).center)!
                EntityContainer.entities[item.modelName] = food
                
            } else { // load the USDZs
                let food = try! Entity.load(named: item.modelName)
                food.createSpinComponent()
                food.scale *= 0.1 / food.visualBounds(relativeTo: nil).boundingRadius
                food.position.y -= food.visualBounds(relativeTo: nil).center.y
                EntityContainer.entities[item.modelName] = food
            }
            
            // MARK: load the assets to be displayed in the cart
            let cartFoodModel = try! Entity.load(named: item.modelName)
            cartFoodModel.createSpinComponent(speed: 0.3)
            cartFoodModel.scale *= 0.05 / cartFoodModel.visualBounds(relativeTo: nil).boundingRadius
            cartFoodModel.position.y -= cartFoodModel.visualBounds(relativeTo: nil).center.y
            EntityContainer.cartEntities[item.modelName] = cartFoodModel
        }
    }
    
}


class Model: ObservableObject {
    @Published var currentView: ViewState = .home
    @Published var currentSelectionID: Int?
    @Published var cart = CartModel()
    @Published var isCartOpen: Bool = false
    
    init(currentView: ViewState = .home) {
        self.currentView = currentView
    }
}


struct FoodItemModel: Hashable, Identifiable, Equatable {
    var id: Int
    var name: String
    var modelName: String
    var description: String
    var price: Float
    var category: FoodCategory
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(modelName)
    }
    
    static func == (lhs: FoodItemModel, rhs: FoodItemModel) -> Bool {
        return lhs.id == rhs.id
    }
}


struct Data {
    static let description: String = "This is a very good food that very good people eat to be very good."
    static let foodItems = [
        FoodItemModel(id: 0, name: "Hot Dog", modelName: "HotDog", description: Data.description, price: 7.0, category: .grill),
        FoodItemModel(id: 1, name: "Cheese Burger", modelName: "Cheeseburger", description: Data.description, price: 10.0, category: .grill),
        FoodItemModel(id: 2, name: "French Fries", modelName: "FrenchFries", description: Data.description, price: 4.0, category: .grill),
        FoodItemModel(id: 3, name: "Pizza (Slice)", modelName: "PizzaSlice", description: Data.description, price: 5.0, category: .grill),
        FoodItemModel(id: 4, name: "Apple Pie", modelName: "ApplePie", description: Data.description, price: 4.0, category: .desserts),
        FoodItemModel(id: 5, name: "Cookie", modelName: "Cookie", description: Data.description, price: 4.0, category: .desserts),
        FoodItemModel(id: 6, name: "Lava Cake", modelName: "LavaCake", description: Data.description, price: 4.0, category: .desserts),
        FoodItemModel(id: 7, name: "Cupcake", modelName: "CupCake", description: Data.description, price: 4.0, category: .desserts),
        FoodItemModel(id: 8, name: "Milk", modelName: "BabyBottle", description: "Fresh milk, rich with calcium and protein, suitable for babies or adults. Ideal for a calcium-rich day.", price: 3.0, category: .drinks),
        FoodItemModel(id: 9, name: "Coffee", modelName: "CoffeeCup", description: Data.description, price: 3.0, category: .drinks),
        FoodItemModel(id: 10, name: "Soda Fountain", modelName: "Soda", description: Data.description, price: 3.0, category: .drinks),
        FoodItemModel(id: 11, name: "Soda Can", modelName: "SodaCan", description: Data.description, price: 3.0, category: .drinks),
//        FoodItemModel(id: 12, name: "Sake", modelName: "Sake", description: Data.description, price: 3.0, category: .drinks)
    ]
    
    static var grills: [FoodItemModel] {
        return foodItems.filter({$0.category == .grill})
    }
    
    static var drinks: [FoodItemModel] {
        return foodItems.filter({$0.category == .drinks})
    }
    
    static var desserts: [FoodItemModel] {
        return foodItems.filter({$0.category == .desserts})
    }
    
    static var menu: [String : [FoodItemModel]] = [
        FoodCategory.drinks.rawValue : drinks,
        FoodCategory.grill.rawValue : grills,
        FoodCategory.desserts.rawValue : desserts
    ]
}
