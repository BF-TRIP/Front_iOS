//
//  OnboardingFifthView.swift
//  BF_TRIP
//
//  Created by 박동재 on 2/10/25.
//

import SwiftUI

struct OnboardingFifthView: View {
    
    @ObservedObject var viewModel: OnboardingViewModel
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("추구하는 여행 스타일을")
                .font(.system(size: 24, weight: .semibold))
                .foregroundStyle(Color.Black)
            Text("선택해주세요.")
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
            toggleButton(title1: "숲속 힐링", title2: "자연, 산림욕장, 휴양림", title3: "", image: Image(uiImage: .camping), index: 0)
            toggleButton(title1: "해변 & 물놀이", title2: "해수욕장, 물놀이, 호수", title3: "", image: Image(uiImage: .beach), index: 1)
        }
        .padding(.horizontal, 10)
        
        HStack(spacing: 10) {
            toggleButton(title1: "문화유산 & 역사", title2: "박물관, 역사,", title3: "문화, 종교시설", image: Image(uiImage: .historical), index: 2)
            toggleButton(title1: "엔터테인먼트", title2: "가족, 공원, 레저", title3: "테마파크", image: Image(uiImage: .amuse), index: 3)
        }
        .padding(.horizontal, 10)
        
        Button {
            viewModel.toggleTripNoneApply()
        } label: {
            Text("해당사항 없음")
                .font(.system(size: 15, weight: viewModel.tripNoneApplySelected ? .semibold : .medium))
                .frame(maxWidth: .infinity)
                .contentTransition(.identity)
        }
        .frame(height: 50)
        .padding(.vertical, 10)
        .background(viewModel.tripNoneApplySelected ? Color.SubColor : Color.White.opacity(0))
        .foregroundColor(Color.Black)
        .cornerRadius(15)
        .overlay {
            RoundedRectangle(cornerRadius: 15)
                .stroke(viewModel.tripNoneApplySelected ? Color.MainColor : Color.Gray300)
        }
        .padding(.horizontal, 10)
        
    }
    
    func toggleButton(title1: String, title2: String, title3: String, image: Image, index: Int) -> some View {
        Button {
            viewModel.toggleTrip(at: index)
        } label: {
            ZStack {
                VStack(alignment: .leading) {
                    HStack {
                        Text(title1)
                            .font(.system(size: 16, weight: .semibold))
                            .contentTransition(.identity)
                        Spacer()
                    }
                    HStack {
                        Text(title2)
                            .font(.system(size: 10, weight: .medium))
                            .contentTransition(.identity)
                            .foregroundColor(Color.Gray600)
                        Spacer()
                    }
                    .padding(.top, 3)
                    HStack {
                        Text(title3)
                            .font(.system(size: 10, weight: .medium))
                            .contentTransition(.identity)
                            .foregroundColor(Color.Gray600)
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
                            .frame(width: 55, height: 55)
                    }
                }
            }
        }
        .frame(width: UIScreen.main.bounds.width * 0.37, height: UIScreen.main.bounds.height * 0.1)
        .padding()
        .background(viewModel.tripList[index] ? Color.SubColor : Color.White.opacity(0))
        .foregroundColor(Color.Black)
        .cornerRadius(15)
        .overlay {
            RoundedRectangle(cornerRadius: 15)
                .stroke(viewModel.tripList[index] ? Color.MainColor : Color.Gray300)
        }
    }
    
}
