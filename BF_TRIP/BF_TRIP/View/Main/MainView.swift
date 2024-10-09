//
//  MainView.swift
//  BF_TRIP
//
//  Created by 박동재 on 10/4/24.
//

import SwiftUI

struct MainView: View {
    
    @State var isVoiceViewShowing: Bool = false
    
    var body: some View {
        let webView = WebKit(
                request: URLRequest(url: URL(string: "http://localhost:5173/home")!),
                isVoiceViewShowing: $isVoiceViewShowing
            )
        
        return webView
        .fullScreenCover(isPresented: $isVoiceViewShowing, content: {
            VoiceView(isVoiceViewShowing: $isVoiceViewShowing)
        })
        .transaction { transaction in
            transaction.disablesAnimations = true
        }
        .onAppear(perform: {
            webView.callJS(gpsX: 126.98, gpsY: 37.57)
            dump("123123")
        })
    }
}
