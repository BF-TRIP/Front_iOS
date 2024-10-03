//
//  SearchBar.swift
//  BE-TRIP
//
//  Created by 박동재 on 9/28/24.
//

import SwiftUI

struct SearchBar: View {
    
    @State var isSearchViewShowing: Bool = false
    @State var text: String = ""
    
    var body: some View {
        HStack {
            TextField("검색어를 입력해주세요.", text: self.$text)
                .padding(15)
                .padding(.horizontal, 15)
                .background(Color(.systemGray6))
                .cornerRadius(15)
                .overlay(
                    HStack {
                        Spacer()
                        Button {
                            //TODO: 음성녹음 띄우기
                        } label: {
                            Image(systemName: "mic")
                                .foregroundColor(Color(.label))
                                .padding()
                        }
                    }
                )
                .onTapGesture {
                    self.isSearchViewShowing = true
                }
                .fullScreenCover(isPresented: $isSearchViewShowing, content: {
                    SearchView(isSearchViewShowing: $isSearchViewShowing, text: self.$text)
                })
                .transaction { transaction in
                    transaction.disablesAnimations = true
                }
        }
    }
}
