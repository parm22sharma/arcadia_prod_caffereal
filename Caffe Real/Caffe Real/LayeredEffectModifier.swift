////
////  LayeredEffectModifier.swift
////  Caffe Real
////
////  Created by Sina Karachiani on 4/19/23.
////
//
//import SwiftUI
//
//
////  Written by SerialCoder.dev
//struct LayeredEffectModifier: ViewModifier {
//    var numOfLayers: Int
//    var reduceOpacity: Bool
//    var increaseScale: Bool
//    var useAnimation: Bool
//    var offsetScale: Double
//    @State private var _offsetScale: Double
//    
//    init(numOfLayers: Int = 5, reduceOpacity: Bool = true, increaseScale: Bool = false, offsetScale: Double = 15, useAnimation: Bool = true) {
//        self.numOfLayers = numOfLayers
//        self.reduceOpacity = reduceOpacity
//        self.increaseScale = increaseScale
//        self.useAnimation = useAnimation
//        self.offsetScale = offsetScale
//        if self.useAnimation {
//            self._offsetScale = 0
//        } else {
//            self._offsetScale = self.offsetScale
//        }
//    }
//
//    
//    func body(content: Content) -> some View {
//        ZStack{
//            ForEach(1...numOfLayers, id: \.self) { offset in
//                content
//                    .offset(y: -1 * Double(offset) * _offsetScale / 5 , z: -1 * Double(offset) * _offsetScale / 7)
//                    .opacity(reduceOpacity ? (offset == 1 ? 1.0 : (8.0 - Double(offset)) / 50) : 1.0)
//                    .scaleEffect(increaseScale ? (offset == 1 ? 1.0 : (1 + Double(offset)/20)) : 1.0)
//            }
//        }
//        .onAppear{
//            if self.useAnimation {
//                withAnimation(.interpolatingSpring(stiffness: 400, damping: 5)) {
//                    _offsetScale = offsetScale
//                }
//            }
//        }
//    }
//}
//
//
////  Written by SerialCoder.dev
//extension View {
//    func addLayerEffect(numOfLayers: Int = 5, reduceOpacity: Bool = true, increaseScale: Bool = false, offsetScale: Double = 15, useAnimation: Bool = true) -> some View {
//        modifier(LayeredEffectModifier(numOfLayers: numOfLayers, reduceOpacity: reduceOpacity, increaseScale: increaseScale, offsetScale: offsetScale, useAnimation: useAnimation))
//    }
//}
