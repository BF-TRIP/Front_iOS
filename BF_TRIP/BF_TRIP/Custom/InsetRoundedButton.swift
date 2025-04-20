//
//  InsetRoundedButton.swift
//  BF_TRIP
//
//  Created by 박동재 on 3/3/25.
//

import SwiftUI

struct InsetRoundButton: ButtonStyle {
  
  func makeBody(configuration: Configuration) -> some View {
    configuration.label
          .foregroundColor(Color.White)
      .padding(.horizontal, 35)
      .padding(.vertical, 15)
      .background(Capsule().fill(Color.Black))
      .scaleEffect(configuration.isPressed ? 0.9 : 1.0)
  }
}
