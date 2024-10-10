//
//  ResponseSaveDTO.swift
//  BF_TRIP
//
//  Created by 박동재 on 10/10/24.
//

import Foundation

struct ResponseSaveDTO: Codable {
    
    let contentId: Int
    let contentTitle: String
    let addr: String
    let thumbnailImage: String
    
    enum CodingKeys: String, CodingKey {
        case contentId = "content_id"
        case contentTitle = "content_title"
        case addr
        case thumbnailImage = "thumbnail_image"
    }
    
}
