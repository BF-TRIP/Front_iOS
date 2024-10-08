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
    
    init(viewModel: MapViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        VStack {
            HStack {
                Button {
                    self.isFilterViewShowing = true
                } label: {
                    Image(systemName: "line.3.horizontal")
                        .foregroundColor(Color(.label))
                }
                
                Spacer()
                
                SearchBar()
            }
            .padding(EdgeInsets(top: 5, leading: 15, bottom: 5, trailing: 15))
            
            Map(coordinateRegion: $viewModel.region,
                showsUserLocation: true,
                annotationItems: self.viewModel.placeList,
                annotationContent: { location in
                MapAnnotation(coordinate: CLLocationCoordinate2D(latitude: location.gpsY, longitude: location.gpsX)) {
                    LocationMapAnnotation()
                }
            })
            .onAppear {
                self.cameraPosition = .region(self.viewModel.region)
            }
            .fullScreenCover(isPresented: $isFilterViewShowing, content: {
                SearchFilterView(isFilterViewShowing: $isFilterViewShowing)
            })
            .transaction { transaction in
                transaction.disablesAnimations = true
            }
        }
    }
    
}

