//
//  SaveCourseView.swift
//  BF_TRIP
//
//  Created by 박동재 on 3/9/25.
//

import SwiftUI

struct SaveCourseView: View {
    
    @Binding var course: tmp
    
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
                Text("\(course.courseName)")
                    .font(.system(size: 18, weight: .semibold))
                    .foregroundColor(.black)
//                Text("\(course.area)")
                Text("지역")
                    .font(.system(size: 12, weight: .medium))
                    .foregroundColor(Color(hex: "#676767"))
                    .padding(.top, 1)
                HStack {
//                    Text("\(course.startDate)~\(course.endDate)")
                    Text("03.12-03.14")
                        .font(.system(size: 12, weight: .medium))
                        .foregroundColor(.black)
                    Text("[2박3일]")
                        .font(.system(size: 12, weight: .medium))
                        .foregroundColor(.black)
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
