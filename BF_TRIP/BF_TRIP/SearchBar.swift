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
            Button {
                isSearchViewShowing = true
            } label: {
                Text("검색어를 입력해주세요.")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(15)
                    .padding(.horizontal, 15)
                    .foregroundColor(Color(.placeholderText))
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
            }
            .fullScreenCover(isPresented: $isSearchViewShowing, content: {
                SearchView(isSearchViewShowing: $isSearchViewShowing, text: self.$text)
            })
            .transaction { transaction in
                transaction.disablesAnimations = true
            }
            .background(.clear)
        }
    }
}


#Preview {
    SearchBar()
}
