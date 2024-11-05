//
//  BookmarkView.swift
//  BF_TRIP
//
//  Created by 박동재 on 10/4/24.
//

import SwiftUI

struct BookmarkView: View {
    
    @State var isVoiceViewShowing: Bool = false
    @State var isOnboarding: Bool = false
    
    var body: some View {
        let webView = WebKit(
            request: URLRequest(url: URL(string: "https://bf-trip.netlify.app/save-list")!),
            isVoiceViewShowing: $isVoiceViewShowing,
            isOnboarding: $isOnboarding
        )
        
        VStack {
            webView
                .transaction { transaction in
                    transaction.disablesAnimations = true
                }
                .background(Color(hex: "#FFE023"))
                .background(ignoresSafeAreaEdges: .top)
                .scrollIndicators(.hidden)
        }
    }

}
