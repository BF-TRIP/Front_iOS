//
//  MainView.swift
//  BF_TRIP
//
//  Created by 박동재 on 10/4/24.
//

import SwiftUI

struct MainView: View {
    
    @State var isVoiceViewShowing: Bool = false
    @State var isOnboarding: Bool = false
    
    @State private var userNumber: Int = 0
    @State private var userName: String = ""
    private var gpsX: Double
    private var gpsY: Double
    
    init(gpsX: Double, gpsY: Double) {
        self.gpsX = gpsX
        self.gpsY = gpsY
    }
    
    var body: some View {
        let webView = WebKit(
            request: URLRequest(url: URL(string: "https://mo-haeng.netlify.app/?userNumber=\(userNumber)&userName=\(userName)&gpsX=\(gpsX)&gpsY=\(gpsY)")!),
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
                .scrollIndicators(.hidden)
        }
        .background(Color(hex: "#FFE54A"))
        .background(ignoresSafeAreaEdges: .top)
        .scrollIndicators(.hidden)
        .environment(\.userId, userNumber)
        .environment(\.userName, userName)
    }
}
