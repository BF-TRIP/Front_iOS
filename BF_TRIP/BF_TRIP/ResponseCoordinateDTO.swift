//
//  ResponseCoordinateDTO.swift
//  BF_TRIP
//
//  Created by 박동재 on 10/4/24.
//

import Foundation

struct ResponseCoordinateDTO: Codable {
    
    let contentId: Int
    let contentTitle: String
    let addr: String
    let gpsX: Double
    let gpsY: Double
    let originalImage: String
    let thumbnailImage: String
    let publicTransport: String
    let elevator: String
    let restroom: String
    let wheelchair: String
    let helpDog: String
    let guideHuman: String
    let braileBlock: String
    let signGuide: String
    let videoGuide: String
    let hearingHandicapEtc: String
    let stroller: String
    let lactationRoom: String
    let babySpareChair: String
    
    enum CodingKeys: String, CodingKey {
        case contentId
        case contentTitle
        case addr
        case gpsX
        case gpsY
        case originalImage
        case thumbnailImage
        case publicTransport
        case elevator
        case restroom
        case wheelchair
        case helpDog
        case guideHuman
        case braileBlock
        case signGuide
        case videoGuide
        case hearingHandicapEtc
        case stroller
        case lactationRoom
        case babySpareChair
    }
    
}
