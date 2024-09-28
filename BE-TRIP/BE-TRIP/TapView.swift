//
//  TapView.swift
//  BE-TRIP
//
//  Created by 박동재 on 9/27/24.
//

import SwiftUI
import BottomSheet

struct TapView: View {
    
    @State var bottomSheetPosition: BottomSheetPosition = .relative(0.4)
    
    var body: some View {
        TabView {
            ContentView()
                .tabItem {
                    Image(systemName: "1.square.fill")
                    Text("홈")
                }
            MapView()
                .bottomSheet(
                    bottomSheetPosition: self.$bottomSheetPosition,
                    switchablePositions: [.relative(0.2), .relative(0.4), .relativeTop(0.95)],
                    content: {
                    
                })
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
