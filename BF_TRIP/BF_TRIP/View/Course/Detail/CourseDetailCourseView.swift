//
//  CourseDetailCourseView.swift
//  BF_TRIP
//
//  Created by 박동재 on 3/15/25.
//

import SwiftUI

struct CourseDetailCourseView: View {
    
    @Binding var course: CourseModel
    @Binding var selectedList: [ResponsePlaceDTO]
    @Binding var selectedNumber: Int
    
    private let semiboldFontSize: CGFloat = 20
    private let mediumFontSize: CGFloat = 18
    private let floatingFontSize: CGFloat = 16
    
    var body: some View {
        NavigationStack {
            VStack {
                DaysComponent(
                    course: $course,
                    selectedDay: $selectedNumber
                )
                .padding(.leading, 30)
                .padding(.top, 10)
                
                CourseListView(
                    course: $course,
                    selectedDay: $selectedNumber,
                    selectedList: $selectedList
                )
                .padding(.top, 10)
                .padding(.trailing)
                .padding(.leading)
            }
        }
    }
}
