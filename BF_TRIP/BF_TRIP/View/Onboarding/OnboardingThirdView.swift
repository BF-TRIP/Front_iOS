//
//  OnboardingThirdView.swift
//  BF_TRIP
//
//  Created by 박동재 on 2/10/25.
//

import SwiftUI

struct OnboardingThirdView: View {
    
    @ObservedObject var viewModel: OnboardingViewModel
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("성별은")
                .font(.system(size: 24, weight: .semibold))
                .foregroundStyle(Color.black)
            Text("어떻게 되시나요?")
                .font(.system(size: 24, weight: .semibold))
                .foregroundStyle(Color.black)
            Text("성별 정보를 활용해 당신에 꼭 맞는")
                .font(.system(size: 18))
                .foregroundColor(Color(hex: "6E6E6E"))
                .padding(.top, 5)
            Text("여행 팁과 코스를 추천해드려요")
                .font(.system(size: 18))
                .foregroundColor(Color(hex: "6E6E6E"))
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        
        Spacer()
        
        HStack(spacing: 20) {
            toggleButton(isSelected: viewModel.gender == 0, title: "남성", image: Image(uiImage: .male), index: 0)
            toggleButton(isSelected: viewModel.gender == 1, title: "여성", image: Image(uiImage: .female), index: 1)
        }
        .padding(.horizontal, 10)
    }
    
    func toggleButton(isSelected: Bool, title: String, image: Image, index: Int) -> some View {
        Button {
            if viewModel.gender == index {
                viewModel.updateGender(nil)
            } else {
                viewModel.updateGender(index)
            }
        } label: {
            VStack {
                image
                    .resizable()
                    .frame(width: 60, height: 60)
                Text(title)
                    .font(.system(size: 18, weight: isSelected ? .semibold : .medium))
                    .contentTransition(.identity)
            }
        }
        .frame(width: UIScreen.main.bounds.width * 0.35, height: UIScreen.main.bounds.height * 0.12)
        .padding()
        .background(isSelected ? Color(hex: "FFFCE7") : .white)
        .foregroundColor(.black)
        .cornerRadius(15)
        .overlay {
            RoundedRectangle(cornerRadius: 15)
                .stroke(isSelected ? Color(hex: "FFE54A") : Color(hex: "DFDFDF"))
        }
    }
    
}
