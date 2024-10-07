//
//  MapViewModel.swift
//  BE-TRIP
//
//  Created by 박동재 on 9/27/24.
//

import Foundation
import MapKit
import CoreLocation
import Moya

final class MapViewModel: ObservableObject {
    
    @Published var region: MKCoordinateRegion = MKCoordinateRegion()
    @Published var placeList: [ResponsePlaceDTO] = []
    @Published var gpsX: Double = 0
    @Published var gpsY: Double = 0
    
    func requestRegion() {
        let manager = CLLocationManager()
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.requestWhenInUseAuthorization()
        
        guard let tmpGpsX = manager.location?.coordinate.longitude else { return }
        guard let tmpGpsY = manager.location?.coordinate.latitude else { return }
        
        self.gpsX = tmpGpsX
        self.gpsY = tmpGpsY
        
        self.region = MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: self.gpsY, longitude: self.gpsX),
            span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
        )
        
        MoyaManager.shared.coordinateToList(gpsX: self.gpsX, gpsY: self.gpsY) { result in
            switch result {
            case .success(let data):
                self.placeList = data
            case .failure(let error):
                dump(error.localizedDescription)
            }
        }
    }
    
    func requestState(state: String, city: String) {
        
        MoyaManager.shared.StateToList(state: state, city: city) { result in
            switch result {
            case .success(let data):
                self.placeList = data
            case .failure(let error):
                dump(error.localizedDescription)
            }
        }
    }
    
}
