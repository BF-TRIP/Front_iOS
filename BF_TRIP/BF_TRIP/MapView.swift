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
    private var provider = MoyaProvider<NetworkService>()
    
    var body: some View {
        VStack {
            SearchBar(text: self.$text)
            Map(coordinateRegion: $viewModel.region, showsUserLocation: true)
                .onAppear {
                    viewModel.requestRegion()
                    provider.request(.getList(gpsX: viewModel.gpsX, gpsY: viewModel.gpsY)) { result in
                        switch result {
                        case let .success(response):
                            dump(response)
                        case let .failure(error):
                            dump(error.localizedDescription)
                        }
                    }
                }
        }
    }
    
}
