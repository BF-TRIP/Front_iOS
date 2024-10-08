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
    
    private var defaultList: [ResponsePlaceDTO] = []
    
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
                self.defaultList = data
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
    
    func requestText(text: String) {
        MoyaManager.shared.textToList(text: text) { result in
            switch result {
            case .success(let data):
                self.placeList = data
            case .failure(let error):
                dump(error.localizedDescription)
            }
        }
    }
    
    func seperateList(selectedStates: [Int]) -> [ResponsePlaceDTO] {
        var list = placeList
        var senior: Bool = selectedStates.contains(1)
        var eyes: Bool = selectedStates.contains(2)
        var ears: Bool = selectedStates.contains(3)
        var child: Bool = selectedStates.contains(4)
        
        if selectedStates == [] || selectedStates.contains(0) {
            senior = false
            eyes = false
            ears = false
            child = false
        }
        
        if senior {
            list = list.filter {
                $0.publicTransport != "" ||
                $0.elevator != "" ||
                $0.restroom != "" ||
                $0.wheelchair != ""
            }
        }
        
        if eyes {
            list = list.filter {
                $0.helpDog != "" ||
                $0.guideHuman != "" ||
                $0.braileBlock != ""
            }
        }
        
        if ears {
            list = list.filter {
                $0.signGuide != "" ||
                $0.videoGuide != "" ||
                $0.hearingHandicapEtc != ""
            }
        }
        
        if child {
            list = list.filter {
                $0.stroller != "" ||
                $0.lactationRoom != "" ||
                $0.babySpareChair != ""
            }
        }
        
        return list
    }
    
    func seperateList(selectedStates: [[Int]]) -> [ResponsePlaceDTO] {
        var list = placeList
        let senior: [Int] = selectedStates[0]
        let eyes: [Int] = selectedStates[1]
        let ears: [Int] = selectedStates[2]
        let child: [Int] = selectedStates[3]
        
        
        if senior != [] {
            if senior.contains(0) {
                list = list.filter {
                    $0.publicTransport != "" ||
                    $0.elevator != "" ||
                    $0.restroom != "" ||
                    $0.wheelchair != ""
                }
            } else {
                if senior.contains(1) {
                    list = list.filter { $0.publicTransport != "" }
                } else if senior.contains(2) {
                    list = list.filter { $0.elevator != "" }
                } else if senior.contains(3) {
                    list = list.filter { $0.restroom != "" }
                } else if senior.contains(4) {
                    list = list.filter { $0.wheelchair != "" }
                }
            }
        }
        
        if eyes != [] {
            if eyes.contains(0) {
                list = list.filter {
                    $0.helpDog != "" ||
                    $0.guideHuman != "" ||
                    $0.braileBlock != ""
                }
            } else {
                if eyes.contains(1) {
                    list = list.filter { $0.helpDog != "" }
                } else if senior.contains(2) {
                    list = list.filter { $0.guideHuman != "" }
                } else if senior.contains(3) {
                    list = list.filter { $0.braileBlock != "" }
                }
            }
        }
        
        if ears != [] {
            if ears.contains(0) {
                list = list.filter {
                    $0.signGuide != "" ||
                    $0.videoGuide != "" ||
                    $0.hearingHandicapEtc != ""
                }
            } else {
                if ears.contains(1) {
                    list = list.filter { $0.signGuide != "" }
                } else if senior.contains(2) {
                    list = list.filter { $0.videoGuide != "" }
                } else if senior.contains(3) {
                    list = list.filter { $0.hearingHandicapEtc != "" }
                }
            }
        }
        
        if child != [] {
            if child.contains(0) {
                list = list.filter {
                    $0.stroller != "" ||
                    $0.lactationRoom != "" ||
                    $0.babySpareChair != ""
                }
            } else {
                if ears.contains(1) {
                    list = list.filter { $0.stroller != "" }
                } else if senior.contains(2) {
                    list = list.filter { $0.lactationRoom != "" }
                } else if senior.contains(3) {
                    list = list.filter { $0.babySpareChair != "" }
                }
            }
        }
        
        return list
    }
    
    func changeList(list: [ResponsePlaceDTO]) {
        self.defaultList = self.placeList
        self.placeList = list
    }
    
    func revertList() {
        self.placeList = defaultList
    }
    
}
