//
//  ResponseJoinModel.swift
//  BF_TRIP
//
//  Created by 박동재 on 2/22/25.
//

import Foundation

struct ResponseJoinModel: Codable {
    
    let userNumber: Int
    let userName: String
    
    enum CodingKeys: String, CodingKey {
        case userNumber
        case userName
    }
    
}
