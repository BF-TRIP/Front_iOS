//
//  CourseDetailCourseView.swift
//  BF_TRIP
//
//  Created by 박동재 on 3/15/25.
//

import SwiftUI

struct CourseDetailCourseView: View {
    
    @Binding var course: CourseModel
    @Binding var selectedList: [Course]
    @Binding var selectedNumber: Int
    
    private let backgroundColor = "0A70C9"
    private let defalutColor = "E2E2E2"
    private let fontColor = "FFFFFF"
    
    private let semiboldFontSize: CGFloat = 20
    private let mediumFontSize: CGFloat = 18
    private let floatingFontSize: CGFloat = 16
    
    var body: some View {
        NavigationStack {
            VStack {
//                DaysComponent(
//                    selectedDay: $selectedNumber,
//                    days: 0,
//                    backgroundColor: backgroundColor,
//                    defalutColor: defalutColor,
//                    fontColor: fontColor
//                )
//                .padding(.leading, 30)
//                .padding(.top, 10)
                
                CourseListView(
                    course: $course,
                    selectedDay: $selectedNumber
//                    dayOneList: $course.day1,
//                    dayTwoList: $course.day2,
//                    dayThreeList: $course.day3,
//                    selectedList: $selectedList,
//                    selectedNumber: $selectedNumber
                )
                .padding(.top, 10)
                .padding(.trailing)
                .padding(.leading)
            }
        }
    }
}
