//
//  NetworkService.swift
//  BF_TRIP
//
//  Created by 박동재 on 9/30/24.
//

import Foundation
import Moya

enum NetworkService {
    
    case getList(gpsX: Double, gpsY: Double)
    
}

extension NetworkService: TargetType {
    var baseURL: URL {
        return URL(string: "http://43.203.92.36:8080")!
    }
    
    var path: String {
        switch self {
        case .getList:
            return "/api/map"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getList:
            return .get
        }
    }
    
    var task: Moya.Task {
        switch self {
        case let .getList(gpsX, gpsY):
            let params: [String: Double] = [
                "gpsX": gpsX,
                "gpsY": gpsY
            ]
            return .requestParameters(parameters: params, encoding: URLEncoding.queryString)
        }
    }
    
    var headers: [String : String]? {
        return ["Content-Type": "application/json"]
    }
    
    
    
    
}
