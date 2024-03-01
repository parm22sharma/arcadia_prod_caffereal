//
//  HorizontalSeparator.swift
//  Caffe Real
//
//  Created by Sina Karachiani on 3/9/23.
//

import SwiftUI

struct HorizontalSeparator: View {
    var length: CGFloat = 80
    var body: some View {
        Rectangle()
            .fill(.white)
            .frame(maxWidth: length, maxHeight: 1)
    }
}
