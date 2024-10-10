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
    @State var emtpyShowing: Bool = false
    @State var isOnboarding: Bool = true
    
    var body: some View {
        if isOnboarding {
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
                            PlaceListView(
                                title: "관광지 목록",
                                searching: false,
                                isPlaceListViewShowing: $emtpyShowing,
                                viewModel: self.mapViewModel
                            )
                            .padding(.bottom, 100)
                        })
                    .tabItem {
                        Image(systemName: "map")
                        Text("지도")
                    }
                BookmarkView()
                    .tabItem {
                        Image(systemName: "bookmark")
                        Text("저장")
                    }
                    .background(Color(hex: "#000000"))
                    .background(ignoresSafeAreaEdges: .all)
                    .padding(.bottom, 100)
            }
            .accentColor(Color(.label))
            .onAppear(perform: {
                self.mapViewModel.requestRegion()
            })
        } else {
            OnboardingView()
        }
    }
}

#Preview {
    BFView()
}

