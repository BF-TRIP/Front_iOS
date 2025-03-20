//
//  CourseOnboardingFirstView.swift
//  BF_TRIP
//
//  Created by 박동재 on 2/23/25.
//

import SwiftUI

struct CourseOnboardingFirstView: View {
    
    @ObservedObject var viewModel: OnboardingViewModel
    @State private var selectedButton: String? = nil
    
    let buttons = [
        "서울", "인천", "경기",
        "강원", "세종", "충북",
        "충남", "대전", "전북",
        "전남", "광주", "경북",
        "경남", "부산", "대구",
        "울산", "제주"
    ]
    
    let buttonsArea = [
        1, 2, 31,
        32, 8, 33,
        34, 3, 37,
        38, 5, 35,
        36, 6, 4,
        7, 39
    ]
    
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("어디로 떠날까요?")
                .font(.system(size: 24, weight: .semibold))
                .foregroundStyle(Color.black)
            Text("지역 한 곳을 선택해주세요.")
                .font(.system(size: 16))
                .foregroundColor(Color(hex: "6E6E6E"))
                .padding(.top, 5)
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        
        LazyVGrid(columns: columns, spacing: 10) {
            ForEach(Array(buttons.enumerated()), id: \.offset) { index, button in
                ButtonView(button: button, isSelected: selectedButton == button, action: {
                    if selectedButton == button {
                        selectedButton = nil
                        viewModel.updateArea(nil)
                    } else {
                        selectedButton = button
                        viewModel.updateArea(buttonsArea[index])
                    }
                })
            }
        }
        .padding()
    }
}

struct ButtonView: View {
    let button: String
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Text(button)
                .frame(minWidth: 0, maxWidth: .infinity)
                .frame(height: 48)
                .background(isSelected ? Color(hex: "FFFCE7") : Color.white)
                .foregroundColor(.black)
                .font(.system(size: 18, weight: isSelected ? .semibold : .medium))
                .cornerRadius(40)
                .overlay(
                    RoundedRectangle(cornerRadius: 40)
                        .stroke((isSelected ? Color(hex: "FFE54A") : Color(hex: "676767")), lineWidth: 1)
                )
        }
    }
}
