//
//  NetworkManager.swift
//  BF_TRIP
//
//  Created by 박동재 on 9/30/24.
//

import Foundation
import Moya
import AVFAudio
import AVFoundation

enum NetworkManager {
    
    case getCoordinateToList(gpsX: Double, gpsY: Double)
    case getFileToList(file: URL)
    case getTextToList(text: String)
    case getStateToList(state: String, city: String)
    case getIdToList(userNumber: CLong)
    case postAddSaveList(userNumber: CLong, contentId: CLong)
    
}

extension NetworkManager: TargetType {
    var baseURL: URL {
        return URL(string: "http://43.203.92.36:8080")!
    }
    
    var path: String {
        switch self {
        case .getCoordinateToList(gpsX: _, gpsY: _):
            return "api/map"
        case .getFileToList(file: _):
            return "api/transcription"
        case .getTextToList(text: _):
            return "api/search"
        case .getStateToList(state: _, city: _):
            return "location/district"
        case .getIdToList(userNumber: _):
            return "course/save"
        case .postAddSaveList(userNumber: _, contentId: _):
            return "course/save"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getFileToList(file: _), .postAddSaveList(userNumber: _, contentId: _):
            return .post
        default:
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
            let asset = AVAsset(url: file)
            let exportSession = AVAssetExportSession(asset: asset, presetName: AVAssetExportPresetAppleM4A)
            
            exportSession?.outputURL = file
            exportSession?.outputFileType = .m4a
            
            exportSession?.exportAsynchronously {
                switch exportSession?.status {
                case .completed:
                    dump("success")
                case .failed:
                    dump("failed \(String(describing: exportSession?.error))")
                case .cancelled:
                    dump("cancel")
                default:
                    break
                }
            }
            
            var multiPartData: [Moya.MultipartFormData] = []
            multiPartData.append(
                MultipartFormData(
                    provider: .file(file),
                    name: "file",
                    fileName: "\(file)",
                    mimeType: "audio/m4a")
            )
            
            return .uploadMultipart(multiPartData)
            
        case .getTextToList(text: let text):
            let params: [String: String] = [
                "keyword": text
            ]
            
            return .requestParameters(parameters: params, encoding: URLEncoding.queryString)
            
        case .getStateToList(state: let state, city: let city):
            let params: [String: String] = [
                "state": state,
                "city": city
            ]
            
            return .requestParameters(parameters: params, encoding: URLEncoding.queryString)
            
        case .getIdToList(userNumber: let userNumber):
            let params: [String: CLong] = [
                "userName": userNumber
            ]
            
            return .requestParameters(parameters: params, encoding: URLEncoding.queryString)
            
        case .postAddSaveList(userNumber: let userNumber, contentId: let contentId):
            let params: [String: CLong] = [
                "userName": userNumber,
                "contentId": contentId
            ]
            
            return .requestParameters(parameters: params, encoding: URLEncoding.queryString)
        }
        
    }
    
    var headers: [String : String]? {
        switch self {
        default:
            return ["Content-Type": "application/json"]
        }
    }
    
}
