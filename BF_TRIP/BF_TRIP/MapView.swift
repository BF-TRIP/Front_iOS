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
    
    @StateObject var viewModel: MapViewModel = MapViewModel()
    @State var text: String = ""
    @State private var region: MKCoordinateRegion = MKCoordinateRegion()
    private var provider = MoyaProvider<NetworkService>()
    
    var body: some View {
        VStack {
            SearchBar(text: self.$text)
            Map(coordinateRegion: $region, showsUserLocation: true)
                .onAppear {
                    viewModel.requestRegion()
                    provider.request(.getCoordinateToList(gpsX: viewModel.gpsX, gpsY: viewModel.gpsY)) { result in
                        switch result {
                        case let .success(response):
                            dump(response)
                            region = MKCoordinateRegion(
                                center: CLLocationCoordinate2D(latitude: viewModel.gpsY, longitude: viewModel.gpsX),
                                span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
                            )
                        case let .failure(error):
                            dump(error.localizedDescription)
                        }
                    }
                }
        }
    }
    
}
