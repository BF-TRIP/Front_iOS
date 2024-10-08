//
//  LocationMapAnnotation.swift
//  BF_TRIP
//
//  Created by 박동재 on 10/9/24.
//

import SwiftUI

struct LocationMapAnnotation: View {
    var body: some View {
        VStack(spacing: 0) {
            Image(systemName: "map.circle.fill")
                .resizable()
                .scaledToFit()
                .frame(width: 20, height: 20)
                .font(.headline)
                .padding(6)
                .foregroundColor(.white)
                .background(Color(hex: "#FFE023"))
                .cornerRadius(36)
            
            Image(systemName: "triangle.fill")
                .resizable()
                .scaledToFit()
                .foregroundColor(Color(hex: "#FFE023"))
                .frame(width: 10, height: 10)
                .rotationEffect(Angle(degrees: 180))
                .offset(y: -3)
        }
    }
}
