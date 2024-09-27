//
//  MapView.swift
//  BE-TRIP
//
//  Created by 박동재 on 9/27/24.
//

import SwiftUI
import MapKit
import CoreLocation

struct MapView: View {
    
    @StateObject var viewModel: MapViewModel = MapViewModel()
    @State var text: String = ""
    
    var body: some View {
        VStack {
            SearchBar(text: self.$text)
            Map(coordinateRegion: $viewModel.region, showsUserLocation: true)
                .onAppear {
                    viewModel.requestRegion()
                }
        }
    }
    
}
