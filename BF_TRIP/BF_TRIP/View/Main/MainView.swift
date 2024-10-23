//
//  MainView.swift
//  BF_TRIP
//
//  Created by 박동재 on 10/4/24.
//

import SwiftUI

struct MainView: View {
    
    @State var isVoiceViewShowing: Bool = false
    private var gpsX: Double
    private var gpsY: Double
    
    init(gpsX: Double, gpsY: Double) {
        self.gpsX = gpsX
        self.gpsY = gpsY
    }
    
    var body: some View {
        let webView = WebKit(
                request: URLRequest(url: URL(string: "https://bf-trip.netlify.app/home")!),
                isVoiceViewShowing: $isVoiceViewShowing
            )
        
        VStack { webView
            .fullScreenCover(isPresented: $isVoiceViewShowing, content: {
                VoiceView(isVoiceViewShowing: $isVoiceViewShowing)
            })
            .transaction { transaction in
                transaction.disablesAnimations = true
            }
            .onAppear(perform: {
                webView.callJS(gpsX: gpsX, gpsY: gpsY)
            })
            .background(Color(hex: "#FFE023"))
            .background(ignoresSafeAreaEdges: .top)
            .scrollIndicators(.hidden)
        }
    }
}
