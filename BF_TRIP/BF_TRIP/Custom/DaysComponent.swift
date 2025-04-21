//
//  DaysComponent.swift
//  BF_TRIP
//
//  Created by 박동재 on 3/3/25.
//

import SwiftUI

struct DaysComponent: View {
    
    @Binding var course: CourseModel
    @Binding var selectedDay: Int
        
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 4) {
                ForEach(1...course.locationInfoResList.count, id: \.self) { index in
                    dayButton(for: index)
                }
            }
            .padding(.horizontal, 15)
        }
    }
    
    private func dayButton(for index: Int) -> some View {
        Button(action: {
            selectedDay = index
        }) {
            Text("\(index)일차")
                .font(.system(size: 14))
                .foregroundColor(
                    selectedDay == index
                    ? Color.Black
                    : Color.Gray600
                )
                .padding(.vertical, 5)
                .padding(.horizontal, 15)
        }
        .background(
            selectedDay == index
            ? Color.Yellow
            : Color.Gray300
        )
        .cornerRadius(50)
        .padding(.vertical, 5)
    }

}
