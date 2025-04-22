//
//  MapView.swift
//  BE-TRIP
//
//  Created by 박동재 on 9/27/24.
//

import SwiftUI
import MapKit
import CoreLocation
import Moya

struct MapView: View {

    @State var isFilterViewShowing: Bool = false
    
    @State private var cameraPosition: MapCameraPosition = .automatic
    @ObservedObject var viewModel: MapViewModel

    @State private var offset: CGFloat = 0
    @State private var lastOffset: CGFloat = 0
    @GestureState var gestureOffset: CGFloat = 0

    init(viewModel: MapViewModel) {
        self.viewModel = viewModel
    }

    var body: some View {
        ZStack {
            mapContent

            GeometryReader { proxy -> AnyView in
                let availableHeight = proxy.size.height
                let maxHeight = availableHeight

                let fullOpenOffset: CGFloat = -maxHeight
                let partialOpenOffset: CGFloat = -(maxHeight * 0.5)
                let peekOpenOffset: CGFloat = -(maxHeight * 0.15)

                let threshold1 = maxHeight * 0.25
                let threshold2 = maxHeight * 0.6

                return AnyView(
                    MapBottomSheetView(
                        offset: $offset,
                        mapViewModel: viewModel,
                        height: maxHeight
                    )
                    .offset(y: maxHeight)
                    .offset(y: -offset > 0 ? (-offset <= maxHeight ? offset : fullOpenOffset) : 0)
                    .gesture(DragGesture().updating($gestureOffset, body: { value, out, _ in
                        out = value.translation.height
                        onBottomSheetChange()
                    }).onEnded({ value in
                        let finalDraggedOffset = lastOffset + value.translation.height
                        let visibleHeight = -finalDraggedOffset
                        withAnimation(.interactiveSpring()) {
                            if visibleHeight < threshold1 {
                                offset = peekOpenOffset
                            } else if visibleHeight < threshold2 {
                                offset = partialOpenOffset
                            } else {
                                offset = fullOpenOffset
                            }
                        }
                        lastOffset = offset
                    }))
                    .onAppear {
                        offset = partialOpenOffset
                        lastOffset = offset
                    }
                )
            }
            .ignoresSafeArea(.container, edges: .bottom)
        }
    }

    private var mapContent: some View {
        ZStack(alignment: .top) {
            Map(position: $cameraPosition) {
                ForEach(viewModel.placeList) { location in
                    Annotation(
                        "",
                        coordinate: CLLocationCoordinate2D(latitude: location.gpsY, longitude: location.gpsX),
                        anchor: .bottom
                    ) {
                        LocationMapAnnotation()
                    }
                }
                 UserAnnotation()
            }
            .ignoresSafeArea(edges: .top)
            .onAppear {
                 cameraPosition = .region(viewModel.region)
            }
            
            SearchBar(isFilterViewShowing: $isFilterViewShowing)

        }
        .fullScreenCover(isPresented: $isFilterViewShowing) {
            SearchFilterView(isFilterViewShowing: $isFilterViewShowing)
        }
    }

}

private extension MapView {
    func onBottomSheetChange() {
        DispatchQueue.main.async {
            self.offset = gestureOffset + lastOffset
        }
    }
}
