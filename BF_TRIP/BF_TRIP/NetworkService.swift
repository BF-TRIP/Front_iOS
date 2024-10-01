//
//  NetworkService.swift
//  BF_TRIP
//
//  Created by 박동재 on 9/30/24.
//

import Foundation
import Moya

enum NetworkService {
    
    case getCoordinateToList(gpsX: Double, gpsY: Double)
    case getFileToList(file: URL)
    
}

extension NetworkService: TargetType {
    var baseURL: URL {
        return URL(string: "http://43.203.92.36:8080")!
    }
    
    var path: String {
        switch self {
        case .getCoordinateToList(gpsX: let gpsX, gpsY: let gpsY):
            return "api/map"
        case .getFileToList(file: let file):
            return "api/transcription"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getCoordinateToList(gpsX: let gpsX, gpsY: let gpsY):
            return .get
        case .getFileToList(file: let file):
            return .get
        }
    }
    
    var task: Moya.Task {
        switch self {
        case let .getCoordinateToList(gpsX, gpsY):
            let params: [String: Double] = [
                "gpsX": gpsX,
                "gpsY": gpsY
            ]
            
            return .requestParameters(parameters: params, encoding: URLEncoding.queryString)
        case .getFileToList(file: let file):
            let params: [String: URL] = [
                "file": file
            ]
            
            return .requestParameters(parameters: params, encoding: URLEncoding.queryString)
        }
    }
    
    var headers: [String : String]? {
        return ["Content-Type": "application/json"]
    }
    
}
