//
//  OnboardingMainView.swift
//  BF_TRIP
//
//  Created by 박동재 on 2/9/25.
//

import SwiftUI
import Combine

struct OnboardingMainView: View {
    
    @State private var currentPage: Int = 1
    
    @StateObject var onboardingViewModel: OnboardingViewModel = OnboardingViewModel()
    @Binding var showOnboarding: Bool?
    
    @State private var keyboardHeight: CGFloat = 0
    @FocusState private var isNameFocused: Bool
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                onboardingView(for: currentPage)
                
                Spacer()
                Spacer()
                
                nextButton
                    .padding(.bottom, keyboardHeight > 0 ? keyboardHeight - 300 : 20)
            }
            .toolbar {
                ToolbarItemGroup(placement: .navigationBarLeading) {
                    backButton
                }
                
                ToolbarItemGroup(placement: .navigationBarTrailing) {
                    pageIndicator
                }
            }
            .onReceive(Publishers.keyboardHeight) { self.keyboardHeight = $0 }
        }
    }
    
    private var nextButton: some View {
        Button(action: {
            if currentPage < 6 { currentPage += 1 }
            else if currentPage == 6 {
                Task {
                    do {
                        let response = try await onboardingViewModel.postJoin()
                        
                        await MainActor.run {
                            DataManager.shared.saveUserId(response.userNumber)
                            DataManager.shared.saveUserName(response.userName)
                            print(response.userName)
                            print(response.userNumber)
                            showOnboarding = false
                        }
                    } catch {
                        await MainActor.run {
                            onboardingViewModel.reset()
                            currentPage = 1
                        }
                    }
                }
            }
            isNameFocused = false
        }) {
            Text(currentPage == 6 ? "완료" : "다음")
                .font(.system(size: 20, weight: .bold))
                .frame(width: UIScreen.main.bounds.width * 0.8)
                .frame(height: UIScreen.main.bounds.height * 0.03)
        }
        .buttonStyle(CustomButtonStyle())
    }
    
    private var backButton: some View {
        Group {
            if (2...5).contains(currentPage) {
                Button(action: { currentPage -= 1 }) {
                    Image(systemName: "arrow.left")
                        .foregroundColor(Color.Black)
                }
            }
        }
    }
    
    private var pageIndicator: some View {
        Group {
            if currentPage < 6 {
                Text("\(currentPage)/5")
                    .fontWeight(.semibold)
            }
        }
    }
    
    @ViewBuilder
    func onboardingView(for page: Int) -> some View {
        switch page {
        case 1:
            OnboardingFirstView(viewModel: onboardingViewModel)
        case 2:
            OnboardingSecondView(viewModel: onboardingViewModel)
        case 3:
            OnboardingThirdView(viewModel: onboardingViewModel)
        case 4:
            OnboardingFourthView(viewModel: onboardingViewModel)
        case 5:
            OnboardingFifthView(viewModel: onboardingViewModel)
        case 6:
            OnboardingFinalView()
        default:
            EmptyView()
        }
    }
    
}

extension Publishers {
    static var keyboardHeight: AnyPublisher<CGFloat, Never> {
        let willShow = NotificationCenter.default.publisher(for: UIResponder.keyboardWillShowNotification)
            .map { $0.keyboardHeight }
        
        let willHide = NotificationCenter.default.publisher(for: UIResponder.keyboardWillHideNotification)
            .map { _ in CGFloat(0) }
        
        return MergeMany(willShow, willHide)
            .eraseToAnyPublisher()
    }
}

extension Notification {
    var keyboardHeight: CGFloat {
        return (userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect)?.height ?? 0
    }
}
