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
    let provider: MoyaProvider = MoyaProvider<NetworkService>()
    
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
    
    func fileToList(fileURL: URL, completion: @escaping (Result<String, Error>) -> Void) {
        provider.request(.getFileToList(file: fileURL)) { result in
            switch result {
            case .success(let response):
                completion(.success("file"))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func textToList(text: String, completion: @escaping (Result<String, Error>) -> Void) {
        provider.request(.getTextToList(text: text)) { result in
            switch result {
            case .success(let response):
                completion(.success("123"))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
}
