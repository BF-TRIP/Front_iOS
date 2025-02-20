//
//  OnboardingView.swift
//  BF_TRIP
//
//  Created by 박동재 on 10/10/24.
//

import SwiftUI

struct OnboardingView: View {
    
    @State var isVoiceViewShowing: Bool = false
    @Binding var isOnboarding: Bool
    
    var body: some View {
        let webView = WebKit(
                request: URLRequest(url: URL(string: "http://localhost:5173/onboarding-step1")!),
                isVoiceViewShowing: $isVoiceViewShowing,
                isOnboarding: $isOnboarding
            )
        
        VStack {
            webView
                .fullScreenCover(isPresented: $isVoiceViewShowing, content: {
                    VoiceView(isVoiceViewShowing: $isVoiceViewShowing)
                })
                .transaction { transaction in
                    transaction.disablesAnimations = true
                }
                .task {
                    try? await Task.sleep(for: .seconds(10))
                    webView.sendUUID()
                }
                .scrollDisabled(true)
                .background(Color(.white))
                .background(ignoresSafeAreaEdges: .all)
        }
        .edgesIgnoringSafeArea(.bottom)
    }
}
