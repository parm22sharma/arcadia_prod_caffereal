//
//  TextViews.swift
//  Caffe Real?
//
//  Created by Sina Karachiani on 2/27/23.
//

import SwiftUI

struct DimensionalityText: View {
    let text: String
    @State var offsetScale: Double = 0

    init(_ text: String) { self.text = text}

    var body: some View {
        ZStack {
            // Fake drop shadow
            LargeTitleText(text)
                .foregroundColor(.black)
                .blur(radius: 12)
                .opacity(offsetScale / 30)

            // Stack of text that pushes out away from the UI plane
            ForEach(1...5, id: \.self) { offset in
                LargeTitleText(text)
                    .offset(z: Double(offset) * offsetScale)
                    .opacity(offset == 5 ? 1.0 : Double(offset) / 24.0)
            }
        }
        .onAppear {
            withAnimation(.interpolatingSpring(stiffness: 200, damping: 10)) {
                offsetScale = 20
            }
        }
    }
}


struct LargeTitleText: View {
    let text: String

    static var size: Double = 60.0

    init(_ text: String) { self.text = text }

    var body: some View {
        Text(text)
            .font(.system(size: Self.size, weight: .heavy))
            .lineSpacing(-Self.size / 3)
            .padding()
    }
}


struct TextViews_Previews: PreviewProvider {
    static var previews: some View {
        DimensionalityText("Hello")
    }
}
