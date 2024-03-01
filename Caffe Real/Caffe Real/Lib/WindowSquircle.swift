//
//  WindowSquircle.swift
//  Caffe Real?
//
//  Created by Sina Karachiani on 2/27/23.
//

import SwiftUI

struct WindowCircle: View {
    @EnvironmentObject private var model: Model
    
    var layers: Int = 14
    var body: some View {
        ZStack{
            ForEach(0..<layers, id: \.self) { index in
                Circle()
                    .stroke(lineWidth: model.currentView == .home ? ((Double(layers) - Double(index))/1.5) : 4)
                    .padding(model.currentView == .home ? 10 : 2)
                    .offset(z: model.currentView == .home ? Double(index) * (16.0) : 0)
                    .scaleEffect(1 + (Double(index) / (2*Double(layers))))
                    .opacity((Double(layers)-Double(index))/10.0)
                    .foregroundColor(.gray)
            }
        }
    }
}


// Not used. Possibly remove
struct WindowSquircle: View {
    var layers: Int = 15
    var body: some View {
        ZStack{
            ForEach(0..<layers, id: \.self) { index in
                WindowSquircleShape()
                    .stroke(lineWidth: 3)
                    .offset(z: Double(index) * (21.0))
                    .opacity((Double(layers)-Double(index))/10.0)
                    .foregroundColor(.gray)
            }
        }
    }
}

// Not used. Possibly remove
struct WindowSquircleShape: InsettableShape {
    static let squircle = RoundedRectangle(cornerRadius: 20, style: .continuous)

    func path(in rect: CGRect) -> Path {
        Self.squircle.path(in: rect)
    }

    func inset(by amount: CGFloat) -> some InsettableShape {
        Self.squircle.inset(by: amount)
    }
}


struct WindowCircle_Previews: PreviewProvider {
    static var previews: some View {
        WindowCircle()
    }
}
