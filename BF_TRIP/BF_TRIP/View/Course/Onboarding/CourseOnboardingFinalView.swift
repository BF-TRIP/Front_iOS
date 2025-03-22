//
//  CourseOnboardingFinalView.swift
//  BF_TRIP
//
//  Created by 박동재 on 3/3/25.
//

import SwiftUI

struct CourseOnboardingFinalView: View {
    
    @ObservedObject var viewModel: OnboardingViewModel
    @Binding var isShowing: Bool
    @Binding var isResultViewShowing: Bool
    @Binding var onboardingState: Bool
    @Binding var result: CourseModel
    
    @State private var timer: Timer?
    @State private var userNumber: Int = 0
    
    @State private var currentTextIndex = 0
    private let textMessages = [
        "조금만 기다려주세요",
        "더 나은 접근성을 위한",
        "맞춤 코스를 만들고 있어요"
    ]
    
    private let textSubMessages = [
        "여행에 가져갈 짐 싸는 중...",
        "당신만을 위한 코스 만드는 중..."
    ]
    
    var body: some View {
        ZStack {
            VStack(spacing: 20) {
                if currentTextIndex == 0 {
                    VStack(spacing: 8) {
                        Text(textMessages[currentTextIndex])
                            .font(.system(size: 24, weight: .semibold))
                            .foregroundColor(.black)
                        Text(" ")
                            .font(.system(size: 24, weight: .semibold))
                            .foregroundColor(.black)
                        Text(textSubMessages[currentTextIndex])
                            .font(.system(size: 18, weight: .semibold))
                            .foregroundColor(Color(hex: "6E6E6E"))
                            .padding(.top, 15)
                    }
                    .padding()
                    .padding(.top, 100)
                } else {
                    VStack(spacing: 8) {
                        Text(textMessages[currentTextIndex])
                            .font(.system(size: 24, weight: .semibold))
                            .foregroundColor(.black)
                        Text(textMessages[(currentTextIndex + 1) % textMessages.count])
                            .font(.system(size: 24, weight: .semibold))
                            .foregroundColor(.black)
                        Text(textSubMessages[currentTextIndex])
                            .font(.system(size: 18, weight: .semibold))
                            .foregroundColor(Color(hex: "6E6E6E"))
                            .padding(.top, 15)
                    }
                    .padding()
                    .padding(.top, 100)
                }
                
                Spacer()
            }
            
            LottieView(fileName: "train", loopMode: .loop)
            .padding(.top, 250)
        }
        .padding()
        .onAppear {
            startTextRotation()
        }
        .onDisappear {
            stopTextRotation()
        }
        .task {
            await fetchData()
        }
        .environment(\.userId, userNumber)
    }
    
    private func fetchData() async {
        if onboardingState {
            do {
                result = try await viewModel.postAIQuickRecomnent(userNumber: userNumber)
                isShowing = false
                isResultViewShowing = true
                dump(result)
            } catch {
                print(error.localizedDescription)
                isShowing = false
            }
        } else {
            do {
                result = try await viewModel.postAIRecomnent(userNumber: userNumber)
                isShowing = false
                isResultViewShowing = true
            } catch {
                print(error.localizedDescription)
                isShowing = false
            }
        }
    }
    
    private func startTextRotation() {
        timer = Timer.scheduledTimer(withTimeInterval: 2.5, repeats: true) { _ in
            withAnimation {
                currentTextIndex = (currentTextIndex + 1) % textSubMessages.count
            }
        }
    }
    
    private func stopTextRotation() {
        timer?.invalidate()
        timer = nil
    }
    
}
