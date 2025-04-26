//
//  OnboardingFourthView.swift
//  BF_TRIP
//
//  Created by 박동재 on 2/10/25.
//

import SwiftUI

struct OnboardingFourthView: View {
    
    @ObservedObject var viewModel: OnboardingViewModel
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("특별히 고려해야 할")
                .font(.system(size: 24, weight: .semibold))
                .foregroundStyle(Color.Black)
            Text("점이 있나요?")
                .font(.system(size: 24, weight: .semibold))
                .foregroundStyle(Color.Black)
            Text("중복 선택이 가능해요.")
                .font(.system(size: 18))
                .foregroundColor(Color.Gray600)
                .padding(.top, 5)
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        
        HStack(spacing: 10) {
            toggleButton(title1: "휠체어 사용자 및", title2: "고령자 지원", image: Image(uiImage: .wheelchair), index: 0)
            toggleButton(title1: "시각적 지원", title2: "", image: Image(uiImage: .eyes), index: 1)
        }
        .padding(.horizontal, 10)
        
        HStack(spacing: 10) {
            toggleButton(title1: "청각적 지원", title2: "", image: Image(uiImage: .ears), index: 2)
            toggleButton(title1: "임산부 및 영유아", title2: "동반자 지원", image: Image(uiImage: .pregnant), index: 3)
        }
        .padding(.horizontal, 10)
        
        Button {
            viewModel.toggleNoneApply()
        } label: {
            Text("해당사항 없음")
                .font(.system(size: 15, weight: viewModel.disabilityNoneApplySelected ? .semibold : .medium))
                .frame(maxWidth: .infinity)
                .contentTransition(.identity)
        }
        .frame(height: 50)
        .padding(.vertical, 10)
        .background(viewModel.disabilityNoneApplySelected ? Color.Yellow100 : Color.White.opacity(0))
        .foregroundColor(Color.Black)
        .cornerRadius(15)
        .overlay {
            RoundedRectangle(cornerRadius: 15)
                .stroke(viewModel.disabilityNoneApplySelected ? Color.Yellow : Color.Gray300)
        }
        .padding(.horizontal, 10)
    }
    
    func toggleButton(title1: String, title2: String, image: Image, index: Int) -> some View {
        Button {
            viewModel.toggleDisability(at: index)
        } label: {
            ZStack {
                VStack(alignment: .leading) {
                    HStack {
                        Text(title1)
                            .font(.system(size: 15, weight: viewModel.disabilityList[index] ? .semibold : .medium))
                            .contentTransition(.identity)
                        Spacer()
                    }
                    HStack {
                        Text(title2)
                            .font(.system(size: 15, weight: viewModel.disabilityList[index] ? .semibold : .medium))
                            .contentTransition(.identity)
                        Spacer()
                    }
                    Spacer()
                }
                
                VStack {
                    Spacer()
                    HStack {
                        Spacer()
                        image
                            .resizable()
                            .frame(width: 40, height: 60)
                    }
                }
            }
        }
        .frame(width: UIScreen.main.bounds.width * 0.37, height: UIScreen.main.bounds.height * 0.1)
        .padding()
        .background(viewModel.disabilityList[index] ? Color.Yellow100 : Color.White.opacity(0))
        .foregroundColor(Color.Black)
        .cornerRadius(15)
        .overlay {
            RoundedRectangle(cornerRadius: 15)
                .stroke(viewModel.disabilityList[index] ? Color.Yellow : Color.Gray300)
        }
    }
    
}

