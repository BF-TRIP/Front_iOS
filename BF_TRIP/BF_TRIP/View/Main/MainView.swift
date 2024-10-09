//
//  MainView.swift
//  BF_TRIP
//
//  Created by 박동재 on 10/4/24.
//

import SwiftUI

struct MainView: View {
    
    @State private var isVoiceViewShowing = false
        
    var body: some View {
        WebKit(
            request: URLRequest(url: URL(string: "http://localhost:5173/")!),
            isVoiceViewShowing: $isVoiceViewShowing
        )
        .fullScreenCover(isPresented: $isVoiceViewShowing, content: {
            VoiceView(isVoiceViewShowing: $isVoiceViewShowing)
        })
        .transaction { transaction in
            transaction.disablesAnimations = true
        }
    }
}
