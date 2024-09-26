//
//  TapView.swift
//  BE-TRIP
//
//  Created by 박동재 on 9/27/24.
//

import SwiftUI

struct TapView: View {
    var body: some View {
        TabView {
            ContentView()
                .tabItem {
                    Image(systemName: "1.square.fill")
                    Text("홈")
                }
            ContentView()
                .tabItem {
                    Image(systemName: "2.square.fill")
                    Text("지도")
                }
            ContentView()
                .tabItem {
                    Image(systemName: "3.square.fill")
                    Text("저장")
                }
        }
    }
}
