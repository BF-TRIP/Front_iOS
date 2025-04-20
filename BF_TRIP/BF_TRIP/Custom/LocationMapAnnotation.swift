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
            Image(uiImage: .mapSign)
                .resizable()
                .scaledToFit()
                .frame(width: 30, height: 30)
        }
    }
}
