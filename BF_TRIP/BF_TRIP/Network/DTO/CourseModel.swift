//
//  CourseModel.swift
//  BF_TRIP
//
//  Created by 박동재 on 3/3/25.
//

import Foundation

struct CourseModel: Codable, Hashable {

    let courseInfo: CourseInfo
    let locationInfoResList: [[ResponsePlaceDTO]]
    
}

struct CourseInfo: Codable, Hashable {
    
    let courseNumber: Int
    let courseName: String?
    let area: String?
    let startDate: String?
    let endDate: String?
    let mobility: Bool
    let blind: Bool
    let hear: Bool
    let family: Bool
    
}

struct Course: Codable, Hashable {
    
    var gpsX: Double
    var gpsY: Double
    var contentId: Int
    var contentTypeId: Int
    var name: String
    var address: String
    var imageUrl: String
    
}

struct tmp: Codable, Hashable {
    var courseNumber: Int
    var courseName: String
    var contentIdList: [Course]
}
