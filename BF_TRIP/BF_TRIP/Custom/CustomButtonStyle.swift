//
//  CustomButtonStyle.swift
//  BF_TRIP
//
//  Created by 박동재 on 2/9/25.
//

import SwiftUI

struct CustomButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding()
            .background(Color(hex: "FFE54A"))
            .foregroundColor(.black)
            .opacity(configuration.isPressed ? 0.5 : 1.0)
            .foregroundColor(.white)
            .cornerRadius(10)
            .scaleEffect(configuration.isPressed ? 0.95 : 1)
            .animation(.easeInOut, value: configuration.isPressed)
    }
}
