//
//  CourseOnboardingSecondView.swift
//  BF_TRIP
//
//  Created by 박동재 on 2/23/25.
//

import SwiftUI

struct CourseOnboardingSecondView: View {
    
    @ObservedObject var viewModel: OnboardingViewModel
    @State private var selectedButton: String? = nil
    let buttonTitles = ["당일치기", "1박 2일", "2박 3일"]
    
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("얼마나 떠날까요?")
                .foregroundStyle(Color.Black)
                .font(.system(size: 24, weight: .semibold))
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        
        LazyVGrid(columns: columns, spacing: 10) {
            ForEach(Array(buttonTitles.enumerated()), id: \.offset) { index, button in
                ButtonView(button: button, isSelected: selectedButton == button, action: {
                    if selectedButton == button {
                        selectedButton = nil
                        viewModel.updateDays(nil)
                    } else {
                        selectedButton = button
                        viewModel.updateDays(index + 1)
                    }
                })
            }
        }
        .padding()
        
        Spacer()
        Spacer()
    }
}
