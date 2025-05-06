//
//  BFView.swift
//  BE-TRIP
//
//  Created by 박동재 on 9/27/24.
//

import SwiftUI
import BottomSheet

struct BFView: View {
    
    private let deviceUUID = UIDevice.current.identifierForVendor!.uuidString
    @State var bottomSheetPosition: BottomSheetPosition = .relative(0.3)
    @StateObject var mapViewModel: MapViewModel = MapViewModel()
    @State var emtpyShowing: Bool = false
    @State var isOnboarding: Bool = false
    @State var loading: Bool = false
    
    @Binding var userId: Int?
    @Binding var showOnboarding: Bool?
    
    init(userId: Binding<Int?>, showOnboarding: Binding<Bool?>) {
        UITabBar.appearance().backgroundColor = UIColor(Color.White)
        UIScrollView.appearance().bounces = false
        
        _userId = userId
        _showOnboarding = showOnboarding
    }
    
    var body: some View {
        TabView {
            MainView(gpsX: mapViewModel.gpsX, gpsY: mapViewModel.gpsY, showOnboarding: $showOnboarding)
                .tabItem {
                    Image(systemName: "house")
                    Text("홈")
                }
            MapView(viewModel: mapViewModel)
                .tabItem {
                    Image(uiImage: .map)
                    Text("지도")
                }
            CourseMainView()
                .tabItem {
                    Image(uiImage: .mohaeng)
                    Text("AI코스")
                }
            BookmarkView()
                .tabItem {
                    Image(uiImage: .bookmarkBlack)
                    Text("저장")
                }
        }
        .accentColor(Color(.label))
        .onAppear(perform: {
            self.mapViewModel.requestRegion()
        })
    }

}

struct SplashView: View {
    var body: some View {
        VStack {
            Image(uiImage: .splash)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .clipped()
                .edgesIgnoringSafeArea(.all)
        }
    }
}
