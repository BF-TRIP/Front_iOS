//
//  CourseDetailTitleView.swift
//  BF_TRIP
//
//  Created by 박동재 on 3/15/25.
//

import SwiftUI

struct CourseDetailTitleView: View {
    
    @Binding var course: CourseModel
    
    private let titleFontSize: CGFloat = 24
    private let fontSize: CGFloat = 16
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, content: {
                Image(systemName: "figure.stand")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(height: 30)
                Text(course.courseInfo.courseName ?? "")
                    .font(.system(size: titleFontSize, weight: .semibold))
                HStack {
                    Image(systemName: "location.fill")
                        .resizable()
                        .frame(width: 16, height: 16)
                    Text(course.courseInfo.area ?? "")
                        .font(.system(size: 16, weight: .medium))
                }
                HStack {
                    Image(systemName: "calendar")
                        .resizable()
                        .frame(width: 16, height: 16)
                    Text(course.courseInfo.startDate ?? "")
                        .font(.system(size: 16, weight: .medium))
                    Text("-")
                        .font(.system(size: 16, weight: .medium))
                    Text(course.courseInfo.endDate ?? "")
                        .font(.system(size: 16, weight: .medium))
                }
                .padding(.top, 1)
                
//                CourseDetailNotificationView(list: course.disability)
            })
            
            Spacer()
        }
        .frame(maxWidth: .infinity)
        .padding()
    }
}
