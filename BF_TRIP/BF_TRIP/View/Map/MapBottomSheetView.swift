//
//  MapBottomSheetView.swift
//  BF_TRIP
//
//  Created by 박동재 on 4/21/25.
//

import SwiftUI

struct MapBottomSheetView: View {

    @Binding var offset: CGFloat
    @ObservedObject var mapViewModel: MapViewModel

    @State var emptyShowing: Bool = false

    let height: CGFloat

    var body: some View {
        VStack(spacing: 0) {

            VStack {
                Capsule()
                    .fill(Color.Gray300)
                    .frame(width: 40, height: 5)
                    .padding(.vertical, 10)
            }
            .frame(maxWidth: .infinity)

            PlaceListView(
                title: "관광지 목록",
                searching: false,
                isPlaceListViewShowing: $emptyShowing,
                viewModel: mapViewModel
            )
        }
        .frame(maxWidth: .infinity)
        .frame(height: height)
        .background(Color.White)
        .clipShape(CustomCorner(corners: [.topLeft, .topRight], radius: 30))
    }
    
}
