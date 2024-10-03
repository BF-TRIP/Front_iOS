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
