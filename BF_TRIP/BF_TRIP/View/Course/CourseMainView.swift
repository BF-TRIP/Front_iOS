//
//  CourseMainView.swift
//  BF_TRIP
//
//  Created by 박동재 on 2/20/25.
//

import SwiftUI

struct CourseMainView: View {
    
    @StateObject var onboardingViewModel: OnboardingViewModel = OnboardingViewModel()
    
    @State private var showErrorMessage = false
    @State private var isButtonEnabled = true
    @State private var isCreateViewShowing = false
    @State private var isResultViewShowing = false
    @State private var isOnboardingState = false
    
    @State private var result: CourseModel = CourseModel(
        courseInfo: CourseInfo(
            courseNumber: 0,
            courseName: "",
            area: "",
            image: "",
            gpsX: 0.0,
            gpsY: 0.0,
            startDate: "",
            endDate: "",
            mobility: false,
            blind: false,
            hear: false,
            family: false
        ),
        locationInfoResList: []
    )
//    @State private var number: Int = 25
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                VStack(spacing: 0) {
                    Image(uiImage: .aiCourse)
                        .resizable()
                        .scaledToFit()
                        .frame(height: geometry.size.height * 0.4)
                        .padding(.top, geometry.size.height * 0.05)
                    
                    VStack(spacing: 20) {
                        CourseCustomButton(
                            color: Color.Orange,
                            descriptionColor: Color.Black,
                            title: "빠르게 생성하기",
                            description1: "입력한 정보를 바탕으로",
                            description2: "맞춤형 코스를 만들어드려요.",
                            image: Image(uiImage: .clock)
                        ) {
                            isButtonEnabled = false
                            isOnboardingState = true
                            isCreateViewShowing = true
                            
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                                isButtonEnabled = true
                            }
                        }
                        .disabled(!isButtonEnabled)
                        .fullScreenCover(isPresented: $isCreateViewShowing) {
                            CourseOnboardingMainView(
                                viewModel: onboardingViewModel,
                                showErrorMessage: $showErrorMessage,
                                result: $result,
                                onboardingState: $isOnboardingState,
                                isShowing: $isCreateViewShowing,
                                isResultViewShowing: $isResultViewShowing
                            )
                        }
                        
                        CourseCustomButton(
                            color: Color(hex: "#323232"),
                            descriptionColor: Color.white,
                            title: "세부 조건 다시 고르기",
                            description1: "원하는 조건을 다시 선택하여",
                            description2: "나만의 코스를 만들어드려요.",
                            image: Image(uiImage: .target)
                        ) {
                            isButtonEnabled = false
                            isOnboardingState = false
                            isCreateViewShowing = true
                            
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                                isButtonEnabled = true
                            }
                        }
                        .disabled(!isButtonEnabled)
                        .fullScreenCover(isPresented: $isCreateViewShowing) {
                            CourseOnboardingMainView(
                                viewModel: onboardingViewModel,
                                showErrorMessage: $showErrorMessage,
                                result: $result,
                                onboardingState: $isOnboardingState,
                                isShowing: $isCreateViewShowing,
                                isResultViewShowing: $isResultViewShowing
                            )
                        }
                    }
                    .padding(.leading)
                    .padding(.trailing)
                    .padding(.bottom)
                }
                
                if showErrorMessage {
                    Text("코스 생성에 실패했어요 다시한번 만들어주세요")
                        .font(.headline)
                        .foregroundColor(Color.White)
                        .padding()
                        .background(Color.red)
                        .cornerRadius(10)
                        .transition(.opacity)
                        .zIndex(1)
                }
            }
        }
        .background(Color.SubColor)
        .ignoresSafeArea()
        .fullScreenCover(isPresented: $isResultViewShowing) {
            CourseResultView(isResultShowing: $isResultViewShowing, result: $result)
        }
    }

}

struct CourseCustomButton: View {
    let color: Color
    let descriptionColor: Color
    let title: String
    let description1: String
    let description2: String
    let image: Image
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            ZStack(alignment: .bottomLeading) {
                color
            
                VStack(alignment: .leading, spacing: 5) {
                    Spacer()
                    Text(title)
                        .font(.system(size: 24, weight: .bold))
                        .foregroundColor(Color.White)
                    
                    Spacer().frame(height: 20)
                    
                    Text(description1)
                        .font(.system(size: 16, weight: .medium))
                        .foregroundColor(descriptionColor)
                    Text(description2)
                        .font(.system(size: 16, weight: .medium))
                        .foregroundColor(descriptionColor)
                }
                .padding(.bottom, 30)
                .padding(.leading, 30)
                
                image
                    .resizable()
                    .scaledToFit()
                    .frame(width: 80, height: 80)
                    .position(x: UIScreen.main.bounds.width - 90, y: 90)
            }
            .frame(height: 160)
            .cornerRadius(10)
        }
        .frame(maxWidth: .infinity)
    }
}
