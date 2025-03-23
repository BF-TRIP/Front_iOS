//
//  BF_TRIPApp.swift
//  BF_TRIP
//
//  Created by 박동재 on 10/7/24.
//

import SwiftUI
import KakaoMapsSDK

@main
struct BF_TRIPApp: App {
    
    @State private var userId: Int?
    @State private var userName: String?
    @State private var showOnboarding: Bool? = nil
    @State var isResultShowing: Bool = false
    @State var courseNumber: Int = 25
    
    init() {
        setup()
    }
    
    var body: some Scene {
        WindowGroup {
            if showOnboarding == nil {
                SplashView()
                    .task {
                        try? await Task.sleep(nanoseconds: 1_000_000_000)
                        await handleSplashLogic()
                    }
            } else if showOnboarding == true {
                OnboardingMainView(showOnboarding: $showOnboarding)
            } else {
                BFView(userId: $userId, showOnboarding: $showOnboarding)
            }
        }
        .environment(\.userId, userId)
    }
    
    private func setup() {
//        guard let KAKAO_API_KEY = Bundle.main.KAKAO_API_KEY else { return }
    }
    
    private func handleSplashLogic() async {
        if let loadedUserId = DataManager.shared.loadUserId(),
           let loadedUserName = DataManager.shared.loadUserName() {
            userId = loadedUserId
            userName = loadedUserName
            // TODO: 검증 후, 없으면 온보딩 재시작.
            if let userId = userId {
                do {
                    let vaildation = try await MoyaManager.shared.getUserExist(userNumber: userId)
                    print(vaildation)
                } catch {
                    print(error.localizedDescription)
                }
            }
            showOnboarding = false
        } else {
            showOnboarding = true
        }
    }
    
}
