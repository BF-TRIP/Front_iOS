//
//  OnboardingFinalView.swift
//  BF_TRIP
//
//  Created by 박동재 on 2/10/25.
//

import SwiftUI

struct OnboardingFinalView: View {
    var body: some View {
        Spacer()
        Spacer()
        
        Text("여행 갈 준비가 끝났어요.")
            .font(.system(size: 24, weight: .semibold))
            .foregroundStyle(Color.black)
        LottieView(fileName: "check", loopMode: .playOnce)
            .frame(width: 180, height: 180)
        
        
    }
}
