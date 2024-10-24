//
//  OnboardingView.swift
//  BF_TRIP
//
//  Created by 박동재 on 10/10/24.
//

import SwiftUI

struct OnboardingView: View {
    
    @State var isVoiceViewShowing: Bool = false
    
    var body: some View {
        let webView = WebKit(
                request: URLRequest(url: URL(string: "https://bf-trip.netlify.app/")!),
                isVoiceViewShowing: $isVoiceViewShowing
            )
        
        VStack {
            webView
                .fullScreenCover(isPresented: $isVoiceViewShowing, content: {
                    VoiceView(isVoiceViewShowing: $isVoiceViewShowing)
                })
                .transaction { transaction in
                    transaction.disablesAnimations = true
                }
                .onAppear(perform: {
                    
                })
                .scrollDisabled(true)
                .background(Color(.white))
                .background(ignoresSafeAreaEdges: .all)
        }
        .edgesIgnoringSafeArea(.bottom)
    }
}
