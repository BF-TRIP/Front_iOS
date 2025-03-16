//
//  CourseDetailSegmentView.swift
//  BF_TRIP
//
//  Created by 박동재 on 3/15/25.
//

import SwiftUI

struct CourseDetailSegmentView: View {
    
    @State private var activeTab: SegmentedTab = .course
    @Binding var course: CourseModel
    @Binding var selectedList: [Course]
    @Binding var selectedNumber: Int
    
    var body: some View {
        NavigationStack {
            CourseDetailTitleView(course: $course)
                .padding(.top, 50)
            
            VStack(spacing: 15) {
                SegmentedControl(
                    tabs: SegmentedTab.allCases,
                    activeTab: $activeTab,
                    height: 35,
                    font: .body,
                    activeTint: .black,
                    inactiveTint: .gray.opacity(0.7)
                ) {
                    size in
                    Rectangle()
                        .fill(.black)
                        .frame(height: 2)
                        .padding(.horizontal, 10)
                        .frame(maxHeight: .infinity, alignment: .bottom)
                }
                
            }
            
            if activeTab == .course {
                ScrollView {
                    CourseDetailCourseView(course: $course, selectedList: $selectedList, selectedNumber: $selectedNumber)
                }
            } else if activeTab == .weather {
//                DetailWeatherView()
                EmptyView()
            }
            
            Spacer()
        }
    }
}
