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
    
    func requestRegion() {
        let manager = CLLocationManager()
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.requestWhenInUseAuthorization()
        
        guard let gpsX = manager.location?.coordinate.latitude else { return }
        guard let gpsY = manager.location?.coordinate.longitude else { return }
        
        region = MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: gpsX, longitude: gpsY),
            span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
        )
    }
    
}
