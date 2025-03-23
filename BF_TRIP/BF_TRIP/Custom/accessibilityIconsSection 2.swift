//
//  accessibilityIconsSection.swift
//  BF_TRIP
//
//  Created by 박동재 on 3/9/25.
//

import SwiftUI

struct accessibilityIconsSection: View {
    
    @Binding var place: ResponsePlaceDTO
    
    var body: some View {
        HStack(spacing: 16) {
            accessibilityIcon(
                imageName: .wheelchair,
                isActive:
                    place.publicTransport != ""
                || place.elevator != ""
                || place.restroom != ""
                || place.wheelchair != "")
            
            Spacer()
            
            accessibilityIcon(
                imageName: .senior,
                isActive:
                    place.publicTransport != ""
                || place.elevator != ""
                || place.restroom != ""
                || place.wheelchair != "")
            
            Spacer()
            
            accessibilityIcon(
                imageName: .pregnant,
                isActive:
                    place.stroller != ""
                || place.lactationRoom != ""
                || place.babySpareChair != "")
            
            Spacer()
            
            accessibilityIcon(
                imageName: .eyes,
                isActive:
                    place.helpDog != ""
                || place.guideHuman != ""
                || place.braileBlock != "")
            
            Spacer()
            
            accessibilityIcon(
                imageName: .ears,
                isActive:
                    place.signGuide != ""
                || place.videoGuide != ""
                || place.hearingHandicapEtc != "")
        }
        .frame(maxWidth: .infinity, maxHeight: 48)
        .background(Color.white)
        .padding(EdgeInsets(top: 0, leading: 5, bottom: 15, trailing: 5))
    }
    
    private func accessibilityIcon(imageName: UIImage, isActive: Bool) -> some View {
        Image(uiImage: imageName)
            .resizable()
            .scaledToFit()
            .frame(height: 32)
            .opacity(isActive ? 1.0 : 0.2)
    }
    
}
