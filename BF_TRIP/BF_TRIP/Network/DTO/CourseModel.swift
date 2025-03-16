//
//  CourseModel.swift
//  BF_TRIP
//
//  Created by 박동재 on 3/3/25.
//

import Foundation

struct CourseModel: Codable, Hashable {
    
    let courseNumber: Int
    let courseName: String
    let area: String
    let startDate: String
    let endDate: String
    let period: Int
    let mobility: Bool
    let blind: Bool
    let hear: Bool
    let family: Bool
    let locationInfoResList: [ResponsePlaceDTO]
    
}

struct CourseDetailModel: Codable, Hashable {
    
    let courseNumber: Int
    let courseName: String
    let description: String?
    let locationInfoResList: [ResponsePlaceDTO]
    
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
}
