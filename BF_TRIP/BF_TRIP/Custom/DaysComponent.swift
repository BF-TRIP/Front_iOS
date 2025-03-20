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
    
    let backgroundColor: String
    let defalutColor: String
    let fontColor: String
        
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
                .foregroundColor(Color(hex: fontColor))
                .padding(.vertical, 5)
                .padding(.horizontal, 15)
        }
        .background(selectedDay == index ? Color(hex: backgroundColor) : Color(hex: defalutColor))
        .cornerRadius(50)
        .padding(.vertical, 5)
    }

}
