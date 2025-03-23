//
//  OnboardingSecondView.swift
//  BF_TRIP
//
//  Created by 박동재 on 2/9/25.
//

import SwiftUI

struct OnboardingSecondView: View {
    
    @ObservedObject var viewModel: OnboardingViewModel
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("\(viewModel.name) 님의 생년월일을")
                .font(.system(size: 24, weight: .semibold))
                .foregroundStyle(Color.black)
            Text("알려주세요.")
                .font(.system(size: 24, weight: .semibold))
                .foregroundStyle(Color.black)
            Text("연령대에 맞는 맞춤 추천을 제공해드려요.")
                .font(.system(size: 18))
                .foregroundColor(Color(hex: "6E6E6E"))
                .padding(.top, 5)
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        
        Spacer()
        
        DatePicker(
            "",
            selection: Binding(
                get: { viewModel.birth },
                set: { viewModel.updateBirth($0) }
            ),
            in: ...Date.now,
            displayedComponents: .date
        )
        .datePickerStyle(WheelDatePickerStyle())
        .labelsHidden()
    }
}
