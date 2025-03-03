//
//  CourseView.swift
//  BF_TRIP
//
//  Created by 박동재 on 3/3/25.
//

import SwiftUI

struct CourseView: View {
    
    @Binding var day: Course

    var body: some View {
        HStack {
            courseImage
            
            VStack(alignment: .leading, spacing: 4) {
                Text(day.name)
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundColor(.black)
                Text(day.address)
                    .font(.system(size: 12, weight: .medium))
                    .foregroundColor(.black)
            }
            
            Spacer()
            
            Image(systemName: "line.3.horizontal")
                .foregroundColor(.gray)
        }
        .padding()
    }
    
    private var courseImage: some View {
        Group {
            if let url = URL(string: day.imageUrl) {
                AsyncImage(url: url) { image in
                    image.image?.resizable()
                }
            } else {
                Image(uiImage: .placeholder)
                    .resizable()
            }
        }
        .frame(maxWidth: 55, maxHeight: 64)
        .cornerRadius(4)
        .background(Color.white)
        .clipped()
    }
    
}
