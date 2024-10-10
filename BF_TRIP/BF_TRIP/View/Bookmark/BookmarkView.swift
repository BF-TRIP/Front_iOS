//
//  BookmarkView.swift
//  BF_TRIP
//
//  Created by 박동재 on 10/4/24.
//

import SwiftUI

struct BookmarkView: View {
    
    @State var isVoiceViewShowing: Bool = false
    
    var body: some View {
        let webView = WebKit(
                request: URLRequest(url: URL(string: "http://localhost:5173/save-list")!),
                isVoiceViewShowing: $isVoiceViewShowing
            )
            .edgesIgnoringSafeArea(.all)
        
        return webView
        .fullScreenCover(isPresented: $isVoiceViewShowing, content: {
            VoiceView(isVoiceViewShowing: $isVoiceViewShowing)
        })
        .transaction { transaction in
            transaction.disablesAnimations = true
        }
        .background(Color(hex: "#FFE023"))
        .background(ignoresSafeAreaEdges: .top)
        
    }

}
