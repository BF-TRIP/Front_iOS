//
//  CourseOnboardingMainView.swift
//  BF_TRIP
//
//  Created by 박동재 on 2/23/25.
//

import SwiftUI

struct CourseOnboardingMainView: View {
    
    @StateObject var onboardingViewModel: OnboardingViewModel = OnboardingViewModel()
    
    @State private var currentStartPage: Int = 1
    @State private var currentRestartPage: Int = 1
    
    @Binding var onboardingState: Bool
    @Binding var isShowing: Bool
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                if onboardingState {
                    startOnboardingView(for: currentStartPage)
                } else {
                    restartOnboardingView(for: currentRestartPage)
                }
                
                Spacer()
                Spacer()
                
                nextButton
            }
            .toolbar {
                ToolbarItemGroup(placement: .navigationBarLeading) {
                    backButton
                }
                
                ToolbarItemGroup(placement: .navigationBarTrailing) {
                    pageIndicator
                }
            }
            .background(Color.white)
        }
    }
    
    private var nextButton: some View {
        Button(action: handleNextAction) {
            Text(buttonText)
                .font(.system(size: 20, weight: .bold))
                .frame(width: UIScreen.main.bounds.width * 0.8, height: UIScreen.main.bounds.height * 0.03)
        }
        .buttonStyle(CustomButtonStyle())
    }

    private var buttonText: String {
        if onboardingState {
            return currentStartPage == 2 ? "완료" : "다음"
        } else {
            return currentRestartPage == 4 ? "완료" : "다음"
        }
    }

    private func handleNextAction() {
        if onboardingState {
            if currentStartPage < 2 {
                currentStartPage += 1
            } else if currentStartPage == 2 {
                finishOnboarding()
            } else {
                finishOnboarding()
            }
        } else {
            if currentRestartPage < 4 {
                currentRestartPage += 1
            } else if currentStartPage == 4 {
                finishOnboarding()
            } else {
                finishOnboarding()
            }
        }
    }

    private func finishOnboarding() {
        isShowing = false
    }
    
    private var backButton: some View {
        Group {
            if onboardingState
                ? (1...2).contains(currentStartPage)
                : (1...4).contains(currentRestartPage) {
                Button(action: decrementPage) {
                    Image(systemName: "arrow.left")
                        .foregroundColor(.black)
                }
            }
        }
    }
    
    private func decrementPage() {
        if onboardingState {
            if currentStartPage == 1 {
                isShowing = false
            } else {
                currentStartPage -= 1
            }
        } else {
            if currentRestartPage == 1 {
                isShowing = false
            }
            currentRestartPage -= 1
        }
    }
    
    private var pageIndicator: some View {
        Group {
            if let indicatorText = getIndicatorText() {
                Text(indicatorText)
                    .fontWeight(.semibold)
                    .foregroundStyle(Color.black)
            }
        }
    }

    private func getIndicatorText() -> String? {
        if onboardingState && currentStartPage < 3 {
            return "\(currentStartPage)/2"
        } else if !onboardingState && currentRestartPage < 5 {
            return "\(currentRestartPage)/4"
        }
        return nil
    }
    
    @ViewBuilder
    func startOnboardingView(for page: Int) -> some View {
        switch page {
        case 1:
            CourseOnboardingFirstView(viewModel: onboardingViewModel)
        case 2:
            CourseOnboardingSecondView(viewModel: onboardingViewModel)
        default:
            EmptyView()
        }
    }
    
    @ViewBuilder
    func restartOnboardingView(for page: Int) -> some View {
        switch page {
        case 1:
            OnboardingFourthView(viewModel: onboardingViewModel)
        case 2:
            CourseOnboardingFirstView(viewModel: onboardingViewModel)
        case 3:
            CourseOnboardingSecondView(viewModel: onboardingViewModel)
        case 4:
            OnboardingFifthView(viewModel: onboardingViewModel)
        default:
            EmptyView()
        }
    }
    
}
