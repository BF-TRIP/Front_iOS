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
    
    @State private var userName = DataManager.shared.loadUserName()
    @State private var userNumber = DataManager.shared.loadUserId()
    private var gpsX: Double
    private var gpsY: Double
    
    @Binding var showOnboarding: Bool?
    
    init(gpsX: Double, gpsY: Double, showOnboarding: Binding<Bool?>) {
        self.gpsX = gpsX
        self.gpsY = gpsY
        _showOnboarding = showOnboarding
    }
    
    var body: some View {
        let webView = WebKit(
            request: createURLRequest(userNumber: userNumber, userName: userName, gpsX: gpsX, gpsY: gpsY),
            isVoiceViewShowing: $isVoiceViewShowing,
            isOnboarding: $isOnboarding,
            showOnboarding: $showOnboarding
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
    }
    
    func createURLRequest(userNumber: Int?, userName: String?, gpsX: Double, gpsY: Double) -> URLRequest {
        let baseURLString = "https://mo-haeng.netlify.app/?"
        if let userNumber = userNumber,
           let userName = userName {
            let URLString = "userNumber=\(userNumber)&userName=\(userName)&gpsX=\(gpsX)&gpsY=\(gpsY)"
            
            return URLRequest(url: URL(string: "\(baseURLString)\(URLString)")!)
        } else {
            return URLRequest(url: URL(string: "\(baseURLString)")!)
        }
    }
}
