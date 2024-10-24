//
//  ResponseSaveDTO.swift
//  BF_TRIP
//
//  Created by 박동재 on 10/10/24.
//

import Foundation

struct ResponseSaveDTO: Codable {
    
    let courseNumber: Int
    let courseName: String
    let locNumber: UInt64
    
    enum CodingKeys: String, CodingKey {
        case courseNumber
        case courseName
        case locNumber
    }
    
}
