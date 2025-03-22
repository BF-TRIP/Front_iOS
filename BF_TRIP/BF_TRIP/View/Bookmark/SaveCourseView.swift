//
//  SaveCourseView.swift
//  BF_TRIP
//
//  Created by 박동재 on 3/9/25.
//

import SwiftUI

struct SaveCourseView: View {
    
    @Binding var course: CourseInfo
    
    var body: some View {
        HStack {
//            if let url = URL(string: course.originalImage) {
//                AsyncImage(url: url) { image in
//                    image.image?.resizable()
//                }
//                .frame(maxWidth: 70, maxHeight: 80)
//                .cornerRadius(4)
//                .background(Color(.white))
//                .clipped()
//            } else {
                Image(uiImage: .placeholder)
                    .resizable()
                    .cornerRadius(4)
                    .frame(maxWidth: 70, maxHeight: 80)
                    .background(Color(hex: "#F6F5FA"))
                    .clipped()
//            }
            
            VStack(alignment: .leading, content: {
                Text(course.courseName ?? "")
                    .font(.system(size: 18, weight: .semibold))
                    .foregroundColor(.black)
                HStack {
                    Text(course.startDate ?? "")
                        .font(.system(size: 12, weight: .medium))
                        .foregroundColor(Color(hex: "#676767"))
                    Text("~")
                        .font(.system(size: 12, weight: .medium))
                        .foregroundColor(Color(hex: "#676767"))
                    Text(course.endDate ?? "")
                        .font(.system(size: 12, weight: .medium))
                        .foregroundColor(Color(hex: "#676767"))
                }
                HStack {
                    Image(systemName: "location.fill")
                        .resizable()
                        .frame(width: 12, height: 12)
                    Text(course.area ?? "")
                        .font(.system(size: 12, weight: .medium))
                }
            })
            .padding(.leading, 10)
            
            Spacer()
            
            Image(systemName: "line.3.horizontal")
                .foregroundColor(.gray)
        }
        .padding()
    }
}
