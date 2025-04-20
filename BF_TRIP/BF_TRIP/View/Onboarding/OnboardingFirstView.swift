//
//  OnboardingFirstView.swift
//  BF_TRIP
//
//  Created by 박동재 on 2/4/25.
//

import SwiftUI
import Combine

struct OnboardingFirstView: View {
    
    @ObservedObject var viewModel: OnboardingViewModel
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("가입을 축하드려요🎉")
                .font(.system(size: 24, weight: .semibold))
                .foregroundStyle(Color.Black)
            Text("어떻게 불러드리면 될까요?")
                .font(.system(size: 24, weight: .semibold))
                .foregroundStyle(Color.Black)
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        
        Spacer()
        
        TextField("5글자 내로 입력해주세요.", text: Binding(
            get: { viewModel.name },
            set: { viewModel.updateName($0) }
        ))
        .overlay(
            HStack {
                Spacer()
                Text("\(viewModel.name.count)/5")
                    .foregroundColor(Color.gray)
                    .padding(.trailing, 8)
            }
        )
        .font(.system(size: 20))
        .padding(.horizontal)
        .padding(10)
        .submitLabel(.done)
    }
}
