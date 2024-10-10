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
    
    func IdToList(userNumber: Int, completion: @escaping (Result<[ResponseSaveDTO], Error>) -> Void) {
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
    
    func AddSaveList(userNumber: Int, contentId: Int, completion: @escaping (Result<[ResponseSaveDTO], Error>) -> Void) {
        provider.request(.postAddSaveList(userNumber: userNumber, contentId: contentId)) { result in
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
    
}
