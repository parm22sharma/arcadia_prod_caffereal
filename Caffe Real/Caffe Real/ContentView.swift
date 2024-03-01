//
//  ContentView.swift
//  Caffe Real?
//
//  Created by Sina Karachiani on 2/16/23.
//

import RealityKit
import SwiftUI

struct ContentView: View {
    
    //    @State private var scale: Double = 0
    @State private var viewState: ViewState = .home
    @EnvironmentObject private var model: Model
    @Environment(\.openImmersiveSpace) private var openImmersiveSpace
    @Environment(\.openWindow) private var openWindow
    
    var body: some View {
        ZStack{
            WindowCircle()
                .frame(width: 560, height: 560)
            VStack{
                DimensionalityText("Caffe Real!")
                
                if model.currentView == .home {
                    Button (
                        action: {
                            print("Today's Menu pressed.")
//                            openImmersiveSpace(id: "food_menu")
//                            openWindow(id: "cart")
                            if model.currentView == .home {
                                withAnimation{
                                    model.currentView = .menu
                                }
                            }
                            
                        }, label: {
                            Label("Today's Menu", systemImage: "fork.knife")
                            
                        })
                    .buttonStyle(.borderedProminent)
                    .transition(.scale)
                }
            }
            .frame(minWidth: 500, minHeight: 500, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
            .background(.ultraThinMaterial)
            .glassBackgroundEffect(in: Circle())
              
        
// MARK: - The Menu and Cart View
            if model.currentView != .home {
                ZStack{
                    MenuView()
                        .offset(z: 150)
                        .transition(.opacity)
                    
                   
                    HStack{
                        Spacer()
                        VStack {
                            CartView()
                                .opacity(model.isCartOpen ? 1.0 : 0.0)
                                .transition(.opacity.combined(with: .scale))
                            Spacer()
                                
                        }
                    }
                    .offset(x: -120, y: 85)
                    .offset(z: 60)
                    .transition(.opacity)
                    
                }
            }
        }
    }
}
           
            
//            Button (
//                action: {
//                    print("X BTN Pressed")
//                    // openImmersiveSpace(id: "food_menu")
//
//                    if model.currentView == .foodDetails {
//                        withAnimation{
//                            model.currentView = .menu
//                        }
//                    }
//                    else if model.currentView == .menu {
//                        withAnimation{
//                            model.currentView = .foodDetails
//                        }
//                    }
//
//                    print("Model is: \(model.currentView)")
//
//                }, label: {
//                    Label("Today's Menu", systemImage: "fork.knife")
//                        .padding()
//                        .background(.red)
//                        .foregroundColor(.white)
//                })
//            .offset(y: 200, z: 180)
            


//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView()
//    }
//}


//    VStack {
    //                RealityView { content in
    //                    let mesh = MeshResource.generateSphere(radius: 0.1)
    //                    var material = PhysicallyBasedMaterial()
    //                    material.baseColor = .init(tint: .red)
    //                    let entity = ModelEntity(mesh: mesh, materials: [material])
    //                    content.add(entity)
    //                }
    //                Text("Red Sphere")
    //                    .font(.largeTitle)
    //                    .padding(.top)
    //            }
    //            .padding()
    //            .background(.regularMaterial)
//            }
