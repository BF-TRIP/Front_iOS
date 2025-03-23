//
//  MoyaManager.swift
//  BF_TRIP
//
//  Created by 박동재 on 10/4/24.
//

import Foundation
import Moya

final class MoyaManager {
    
    static let shared = MoyaManager()
    let provider: MoyaProvider = MoyaProvider<NetworkManager>()
    
    func postJoin(
        name: String,
        gender: String,
        birth: String,
        disability: [Int],
        tripType: [Int]
    ) async throws -> ResponseJoinModel {
        return try await withCheckedThrowingContinuation { continuation in
            provider.request(.postJoin(
                name: name,
                gender: gender,
                birth: birth,
                disability: disability,
                tripType: tripType
            )) { result in
                switch result {
                case .success(let response):
                    do {
                        let decoder = JSONDecoder()
                        let jsonData = try decoder.decode(ResponseJoinModel.self, from: response.data)
                        
                        continuation.resume(returning: jsonData)
                    } catch {
                        continuation.resume(throwing: error)
                    }
                case .failure(let error):
                    continuation.resume(throwing: error)
                }
            }
        }
    }
    
    func getUserExist(userNumber: Int) async throws -> Bool {
        return try await provider.requestDecoded(.getUserExist(userNumber: userNumber), as: Bool.self)
    }
    
    func coordinateToList(gpsX: Double, gpsY: Double, completion: @escaping (Result<[ResponsePlaceDTO], Error>) -> Void) {
        provider.request(.getCoordinateToList(gpsX: gpsX, gpsY: gpsY)) { result in
            switch result {
            case .success(let response):
                do {
                    let decoder = JSONDecoder()
                    let jsonData = try decoder.decode([ResponsePlaceDTO].self, from: response.data)
                    
                    completion(.success(jsonData))
                } catch {
                    completion(.failure(error))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func fileToList(fileURL: URL, completion: @escaping (Result<[ResponsePlaceDTO], Error>) -> Void) {
        provider.request(.getFileToList(file: fileURL)) { result in
            switch result {
            case .success(let response):
                do {
                    let decoder = JSONDecoder()
                    let jsonData = try decoder.decode([ResponsePlaceDTO].self, from: response.data)
                    
                    completion(.success(jsonData))
                } catch {
                    completion(.failure(error))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func textToList(text: String, completion: @escaping (Result<[ResponsePlaceDTO], Error>) -> Void) {
        provider.request(.getTextToList(text: text)) { result in
            switch result {
            case .success(let response):
                do {
                    let decoder = JSONDecoder()
                    let jsonData = try decoder.decode([ResponsePlaceDTO].self, from: response.data)
                    
                    completion(.success(jsonData))
                } catch {
                    completion(.failure(error))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func StateToList(state: String, city: String, completion: @escaping (Result<[ResponsePlaceDTO], Error>) -> Void) {
        provider.request(.getStateToList(state: state, city: city)) { result in
            switch result {
            case .success(let response):
                do {
                    let decoder = JSONDecoder()
                    let jsonData = try decoder.decode([ResponsePlaceDTO].self, from: response.data)
                    
                    completion(.success(jsonData))
                } catch {
                    completion(.failure(error))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func AddSaveList(userNumber: Int, contentId: Int) async throws -> String {
        return try await provider.requestDecoded(.postAddSaveList(userNumber: userNumber, contentId: contentId), as: String.self)
    }
    
    func deletePlace(userNumber: Int, contentId: Int) async throws -> String {
        return try await provider.requestDecoded(.deletePlace(userNumber: userNumber, contentId: contentId), as: String.self)
    }
    
    func getSavePlaceList(userNumber: Int) async throws -> [ResponsePlaceDTO] {
        return try await withCheckedThrowingContinuation { continuation in
            provider.request(.getSavePlaceList(userNumber: userNumber)) { result in
                switch result {
                case .success(let response):
                    do {
                        let decoder = JSONDecoder()
                        let jsonData = try decoder.decode([ResponsePlaceDTO].self, from: response.data)
                        
                        continuation.resume(returning: jsonData)
                    } catch {
                        continuation.resume(throwing: error)
                    }
                case .failure(let error):
                    continuation.resume(throwing: error)
                }
            }
        }
    }
    
    func getSaveCourseList(userNumber: Int) async throws -> [CourseInfo] {
        return try await provider.requestDecoded(.getSaveCourseList(userNumber: userNumber), as: [CourseInfo].self)
    }
    
    func postSaveCourseList(
        courseNumber: Int,
        userNumber: Int,
        courseName: String,
        startDate: String
    ) async throws -> CourseModel {
        return try await provider.requestDecoded(
            .postSaveCourseList(
                courseNumber: courseNumber,
                userNumber: userNumber,
                courseName: courseName,
                startDate: startDate
            ), as: CourseModel.self)
    }
    
    func postAIQuickRecomnent(
        userNumber: Int,
        area: Int,
        period: Int
    ) async throws -> CourseModel {
        return try await provider.requestDecoded(
            .postAIQuickRecomnent(
                userNumber: userNumber,
                area: area,
                period: period
            ), as: CourseModel.self)
    }
    
    func postAIRecomnent(
        userNumber: Int,
        area: Int,
        period: Int,
        disability: [Int],
        tripType: [Int]
    ) async throws -> CourseModel {
        return try await provider.requestDecoded(
            .postAIRecomnent(
                userNumber: userNumber,
                area: area,
                period: period,
                disability: disability,
                tripType: tripType
            ), as: CourseModel.self)
    }

    
    func getCourseDetail(courseNumber: Int) async throws -> CourseModel {
        return try await provider.requestDecoded(.getCourseDetail(courseNumber: courseNumber), as: CourseModel.self)
    }

}

extension MoyaProvider {
    func requestDecoded<T: Decodable>(_ target: Target, as type: T.Type) async throws -> T {
        return try await withCheckedThrowingContinuation { continuation in
            self.request(target) { result in
                switch result {
                case .success(let response):
                    do {
                        let decoder = JSONDecoder()
                        let jsonData = try decoder.decode(T.self, from: response.data)
                        continuation.resume(returning: jsonData)
                    } catch {
                        continuation.resume(throwing: error)
                    }
                case .failure(let error):
                    continuation.resume(throwing: error)
                }
            }
        }
    }
}
