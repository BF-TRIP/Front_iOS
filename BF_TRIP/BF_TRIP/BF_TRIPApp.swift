//
//  BF_TRIPApp.swift
//  BF_TRIP
//
//  Created by 박동재 on 10/7/24.
//

import SwiftUI

@main
struct BF_TRIPApp: App {
    
    @State private var userId: Int?
    @State private var showOnboarding: Bool? = nil
    @State var isResultShowing: Bool = false
    @State var courseNumber: Int = 25
    
    var body: some Scene {
        WindowGroup {
            if showOnboarding == nil {
                SplashView()
                    .task {
                        await handleSplashLogic()
                    }
            } else if showOnboarding == true {
                OnboardingMainView(showOnboarding: $showOnboarding)
            } else {
                BFView()
            }
        }
        .environment(\.userId, userId)
    }
    
    private func handleSplashLogic() async {
        if let loadedUserId = DataManager.shared.loadUserId() {
            userId = loadedUserId
            // TODO: 검증 후, 없으면 온보딩 재시작.
            showOnboarding = false
        } else {
            showOnboarding = true
        }
    }
    
}
