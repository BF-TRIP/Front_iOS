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
    
    case postJoin(name: String, gender: String, birth: String, disability: [Int], tripType: [Int])
    case getUserExist(userNumber: Int)
    
    case getCoordinateToList(gpsX: Double, gpsY: Double)
    case getFileToList(file: URL)
    case getTextToList(text: String)
    case getStateToList(state: String, city: String)
    case postAddSaveList(userNumber: Int, contentId: Int)
    case deletePlace(userNumber: Int, contentId: Int)
    
    case postAIQuickRecomnent(userNumber: Int, area: Int, period: Int)
    case postAIRecomnent(userNumber: Int, area: Int, period: Int, disability: [Int], tripType: [Int])
    case getSavePlaceList(userNumber: Int)
    case getSaveCourseList(userNumber: Int)
    
    case postSaveCourseList(courseNumber: Int, userNumber: Int, courseName: String, startDate: String)
    
    case getCourseDetail(courseNumber: Int)
    
}

extension NetworkManager: TargetType {
    var baseURL: URL {
//        return URL(string: "http://223.130.160.52:8080")!
        return URL(string: "http://211.254.215.190:8080")!
    }
    
    var path: String {
        switch self {
        case .postJoin(name: _, gender: _, birth: _, disability: _, tripType: _):
            return "api/user/join"
        case .getUserExist(userNumber: _):
            return "api/user/exist"
            
        case .getCoordinateToList(gpsX: _, gpsY: _):
            return "api/search/map"
        case .getFileToList(file: _):
            return "api/search/transcription"
        case .getTextToList(text: _):
            return "api/search/keyword"
        case .getStateToList(state: _, city: _):
            return "api/location/district"
        case .postAddSaveList(userNumber: _, contentId: _):
            return "api/course/save"
        case .deletePlace(userNumber: let userNumber, contentId: let contentId):
            return "api/course/save/\(userNumber)/\(contentId)"
            
        case .postAIQuickRecomnent(userNumber: _, area: _, period: _):
            return "api/course/ai-rec-quick"
        case .postAIRecomnent(userNumber: _, area: _, period: _, disability: _, tripType: _):
            return "api/course/ai-rec"
        case .getSavePlaceList(userNumber: let userNumber):
            return "api/course/save/\(userNumber)"
        case .getSaveCourseList(userNumber: let userNumber):
            return "api/course/\(userNumber)"
        case .getCourseDetail(courseNumber: let courseNumber):
            return "api/course/\(courseNumber)/list"
        case .postSaveCourseList(courseNumber: _, userNumber: _, courseName: _, startDate: _):
            return "api/course/create"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case
            .getFileToList(file: _),
            .postAddSaveList(userNumber: _, contentId: _),
            .postJoin(name: _, gender: _, birth: _, disability: _, tripType: _),
            .postAIRecomnent(userNumber: _, area: _, period: _, disability: _, tripType: _),
            .postAIQuickRecomnent(userNumber: _, area: _, period: _),
            .postSaveCourseList(courseNumber: _, userNumber: _, courseName: _, startDate: _):
            return .post
        case .deletePlace(userNumber: _, contentId: _):
            return .delete
        default:
            return .get
        }
    }
    
    var task: Moya.Task {
        switch self {
        case let .postJoin(name, gender, birth, disability, tripType):
            let params: [String: Any] = [
                "userName": name,
                "gender": gender,
                "birth": birth,
                "disability": disability,
                "tripType": tripType
            ]
            
            return .requestParameters(parameters: params, encoding: JSONEncoding.default)
            
        case .getUserExist(userNumber: let userNumber):
            let params: [String: Int] = [
                "userNumber": userNumber
            ]
            
            return .requestParameters(parameters: params, encoding: URLEncoding.queryString)
            
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
            
            return .requestParameters(parameters: params, encoding: JSONEncoding.default)
            
        case .postAddSaveList(userNumber: let userNumber, contentId: let contentId):
            let params: [String: Any] = [
                "userNumber": userNumber,
                "contentId": contentId
            ]
            
            return .requestParameters(parameters: params, encoding: JSONEncoding.default)
            
        case .postAIQuickRecomnent(userNumber: let userNumber, area: let area, period: let period):
            let params: [String: Any] = [
                "userNumber": userNumber,
                "area": area,
                "period": period
            ]
            
            return .requestParameters(parameters: params, encoding: JSONEncoding.default)
            
        case .postAIRecomnent(
            userNumber: let userNumber,
            area: let area,
            period: let period,
            disability: let disability,
            tripType: let typeType
        ):
            let params: [String: Any] = [
                "userNumber": userNumber,
                "area": area,
                "period": period,
                "disability": disability,
                "tripType": typeType
            ]
            
            return .requestParameters(parameters: params, encoding: JSONEncoding.default)
            
        case let .postSaveCourseList(courseNumber, userNumber, courseName, startDate):
            let params: [String: Any] = [
                "courseNumber": courseNumber,
                "userNumber": userNumber,
                "courseName": courseName,
                "startDate": startDate
            ]
            
            return .requestParameters(parameters: params, encoding: JSONEncoding.default)
        case .deletePlace(userNumber: _, contentId: _):
            return .requestPlain
        case .getSavePlaceList(userNumber: _):
            return .requestPlain
        case .getSaveCourseList(userNumber: _):
            return .requestPlain
        case .getCourseDetail(courseNumber: _):
            return .requestPlain
        }
        
    }
    
    var headers: [String : String]? {
        switch self {
        default:
            return ["Content-Type": "application/json"]
        }
    }
    
}
