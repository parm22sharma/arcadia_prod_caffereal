//
//  Caffe_Real_App.swift
//  Caffe Real?
//
//  Created by Sina Karachiani on 2/16/23.
//


import SwiftUI

@main
struct Caffe_Real_App: App {
    @StateObject private var model: Model = Model(currentView: .home)
    
    init() {
        SpinComponent.registerComponent()
        SpinSystem.registerSystem()
        EntityContainer.load3DModels()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(model)
        }
        .defaultSize(width: 1200, height: 1000, depth: 500)
        .windowStyle(.plain)
        
        
        // Currently not being used
        ImmersiveSpace(id: "food_menu") {
            MenuView()
                .environmentObject(model)
            
        }
        
        // Currently not being used
        WindowGroup(id: "cart") {
            CartView()
                .environmentObject(model)
                .offset(x: 100, y: 100)
                .offset(z: 100)
        }
        .defaultSize(width: 300, height: 550, depth: 0)
        
    }
}
