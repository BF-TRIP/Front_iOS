//
//  CustomButtonStyle.swift
//  BF_TRIP
//
//  Created by 박동재 on 2/9/25.
//

import SwiftUI

struct CustomButtonStyle: ButtonStyle {
    @Environment(\.isEnabled) private var isEnabled

    func makeBody(configuration: Configuration) -> some View {
        let backgroundColor = isEnabled ? Color.Yellow : Color.Gray100
        let foregroundColor = isEnabled ? Color.Black : Color.Gray400

        configuration.label
            .padding()
            .background(backgroundColor)
            .foregroundColor(foregroundColor)
            .clipShape(RoundedRectangle(cornerRadius: 10))

            .opacity(isEnabled && configuration.isPressed ? 0.5 : 1.0)
            .scaleEffect(isEnabled && configuration.isPressed ? 0.95 : 1.0)
            .animation(isEnabled ? .easeInOut : .none, value: configuration.isPressed)
    }
}
