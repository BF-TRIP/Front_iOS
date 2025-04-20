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
            toggleButton(title1: "숲 속 휴양 및 치유", title2: "울창한, 자연, 치유, 웰빙", title3: "숲속, 산림욕장, 휴양림", image: Image(uiImage: .camping), index: 0)
            toggleButton(title1: "해양 및 수변활동", title2: "해수욕장, 백사장, 물놀이", title3: "댐, 호수", image: Image(uiImage: .beach), index: 1)
        }
        .padding(.horizontal, 10)
        
        HStack(spacing: 10) {
            toggleButton(title1: "역사와 문화유산", title2: "박물관, 미술관, 유적, 역사", title3: "문화, 사찰, 조계종", image: Image(uiImage: .historical), index: 2)
            toggleButton(title1: "함께하는 야외활동", title2: "가족, 어린이, 동반, 공원", title3: "레저, 테마파크", image: Image(uiImage: .amuse), index: 3)
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
                            .font(.system(size: 15, weight: viewModel.tripList[index] ? .semibold : .medium))
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
        .background(viewModel.tripList[index] ? Color.Yellow100 : Color.White.opacity(0))
        .foregroundColor(Color.Black)
        .cornerRadius(15)
        .overlay {
            RoundedRectangle(cornerRadius: 15)
                .stroke(viewModel.tripList[index] ? Color.Yellow : Color.Gray300)
        }
    }
    
}
