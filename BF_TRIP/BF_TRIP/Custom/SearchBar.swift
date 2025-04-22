//
//  SearchBar.swift
//  BE-TRIP
//
//  Created by 박동재 on 9/28/24.
//

import SwiftUI

struct SearchBar: View {
    
    @Binding var isFilterViewShowing: Bool
    
    @State var isSearchViewShowing: Bool = false
    @State var isVoiceViewShowing: Bool = false
    @State var text: String = ""
    
    var body: some View {
        HStack(spacing: 8) {
            Button {
                isFilterViewShowing = true
            } label: {
                Image(systemName: "line.3.horizontal")
                    .font(.system(size: 14))
                    .foregroundColor(Color.Black)
            }
            .padding(.leading, 12)
            
            HStack {
                Text("검색어를 입력해주세요.")
//                    .frame(height: 24)
                    .foregroundColor(Color(.placeholderText))
                    .lineLimit(1)
                Spacer()
            }
            .padding(.vertical, 10)
            .frame(maxWidth: .infinity)
            .cornerRadius(15)
            .onTapGesture {
                isSearchViewShowing = true
            }
            
            Button {
                isVoiceViewShowing = true
            } label: {
                Image(uiImage: .mic)
                    .font(.system(size: 14))
                    .foregroundColor(Color.Black)
            }
            .padding(.trailing, 12)
            
        }
        .fullScreenCover(isPresented: $isSearchViewShowing, content: {
            SearchView(isSearchViewShowing: $isSearchViewShowing, text: self.$text)
        })
        .fullScreenCover(isPresented: $isVoiceViewShowing, content: {
            VoiceView(isVoiceViewShowing: $isVoiceViewShowing)
        })
        .transaction { transaction in
            transaction.disablesAnimations = true
        }
        .background(Color.White)
        .cornerRadius(10)
        .frame(height: 48)
        .padding(.horizontal)
        .padding(.top, 8)
    }
    
}
