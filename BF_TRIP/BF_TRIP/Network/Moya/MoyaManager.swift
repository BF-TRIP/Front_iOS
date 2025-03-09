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
    
    func IdToList(userNumber: String, completion: @escaping (Result<[ResponseSaveDTO], Error>) -> Void) {
        provider.request(.getIdToList(userNumber: userNumber)) { result in
            switch result {
            case .success(let response):
                do {
                    let decoder = JSONDecoder()
                    let jsonData = try decoder.decode([ResponseSaveDTO].self, from: response.data)
                    
                    completion(.success(jsonData))
                } catch {
                    completion(.failure(error))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func AddSaveList(userNumber: String, contentId: UInt64, completion: @escaping (Result<[ResponseSaveDTO], Error>) -> Void) {
        provider.request(.postAddSaveList(userNumber: userNumber, contentId: contentId)) { result in
            switch result {
            case .success(let response):
                do {
                    let decoder = JSONDecoder()
                    let jsonData = try decoder.decode([ResponseSaveDTO].self, from: response.data)
                    
                    print(jsonData)
                    completion(.success(jsonData))
                } catch {
                    print(error)
                    completion(.failure(error))
                }
            case .failure(let error):
                print(error)
                completion(.failure(error))
            }
        }
    }
    
    func checkToID(uuid: String, completion: @escaping (Result<Bool, Error>) -> Void) {
        provider.request(.getUserExist(uuid: uuid)) { result in
            switch result {
            case .success(let response):
                completion(.success((response.response != nil)))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func postAIQuickRecomnent(userNumber: Int, area: Int, period: Int) async throws -> Int {
        return try await withCheckedThrowingContinuation { continuation in
            provider.request(.postAIQuickRecomnent(
                userNumber: userNumber, area: area, period: period
            )) { result in
                switch result {
                case .success(let response):
                    do {
                        let decoder = JSONDecoder()
                        let jsonData = try decoder.decode(Int.self, from: response.data)
                        
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
    
    func postAIRecomnent(
        userNumber: Int,
        area: Int,
        period: Int,
        disability: [Int],
        tripType: [Int]
    ) async throws -> Int {
        return try await withCheckedThrowingContinuation { continuation in
            provider.request(.postAIRecomnent(
                userNumber: userNumber,
                area: area,
                period: period,
                disability: disability,
                tripType: tripType
            )) { result in
                switch result {
                case .success(let response):
                    do {
                        let decoder = JSONDecoder()
                        let jsonData = try decoder.decode(Int.self, from: response.data)
                        
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
    
    func getSaveCourseList(userNumber: Int) async throws -> [ResponsePlaceDTO] {
        return try await withCheckedThrowingContinuation { continuation in
            provider.request(.getSaveCourseList(userNumber: userNumber)) { result in
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

    
}
