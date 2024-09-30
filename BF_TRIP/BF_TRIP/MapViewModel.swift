//
//  MapViewModel.swift
//  BE-TRIP
//
//  Created by 박동재 on 9/27/24.
//

import Foundation
import MapKit
import CoreLocation

final class MapViewModel: ObservableObject {
    
    @Published var region: MKCoordinateRegion = MKCoordinateRegion()
    @Published var gpsX: Double = 0
    @Published var gpsY: Double = 0
    
    func requestRegion() {
        let manager = CLLocationManager()
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.requestWhenInUseAuthorization()
        
        guard let tmpGpsX = manager.location?.coordinate.latitude else { return }
        guard let tmpGpsY = manager.location?.coordinate.longitude else { return }
        
        self.gpsX = tmpGpsX
        self.gpsY = tmpGpsY
    }
    
}
