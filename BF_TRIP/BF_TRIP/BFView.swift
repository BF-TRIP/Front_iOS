//
//  BFView.swift
//  BE-TRIP
//
//  Created by 박동재 on 9/27/24.
//

import SwiftUI
import BottomSheet

struct BFView: View {
    
    @State var bottomSheetPosition: BottomSheetPosition = .relative(0.3)
    @StateObject var mapViewModel: MapViewModel = MapViewModel()
    
    var body: some View {
        TabView {
            MainView()
                .tabItem {
                    Image(systemName: "house")
                    Text("홈")
                }
            MapView(viewModel: mapViewModel)
                .bottomSheet(
                    bottomSheetPosition: self.$bottomSheetPosition,
                    switchablePositions: [.relative(0.3), .relative(0.5), .relativeTop(0.95)],
                    content: {
                        PlaceListView(viewModel: mapViewModel)
                })
                .tabItem {
                    Image(systemName: "map")
                    Text("지도")
                }
            MapView()
                .tabItem {
                    Image(systemName: "bookmark")
                    Text("저장")
                }
        }
        .accentColor(Color(.label))
        .onAppear(perform: {
            self.mapViewModel.requestRegion()
        })
    }
}

#Preview {
    BFView()
}

