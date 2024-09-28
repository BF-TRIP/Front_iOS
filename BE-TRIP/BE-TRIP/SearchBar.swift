//
//  SearchBar.swift
//  BE-TRIP
//
//  Created by 박동재 on 9/28/24.
//

import SwiftUI

struct SearchBar: View {
    
    @Binding var text: String
    @State var editText: Bool = false
    
    var body: some View {
        HStack {
            Button {
                //TODO: 필터 뷰 띄우기
            } label: {
                Image(systemName: "line.3.horizontal")
                    .foregroundColor(Color(.black))
            }
            
            Spacer()

            TextField("검색어를 입력해주세요.", text: self.$text)
                .padding(15)
                .padding(.horizontal, 15)
                .background(Color(.systemGray6))
                .cornerRadius(15)
                .overlay(
                    HStack {
                        Spacer()
                        
                        if self.editText {
                            Button {
                                //TODO: 검색기능 구현
                            } label: {
                                Image(systemName: "magnifyingglass")
                                    .foregroundColor(Color(.black))
                            }
                            Button {
                                self.editText = false
                                self.text = ""
                                UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                            } label: {
                                Image(systemName: "multiply.circle.fill")
                                    .foregroundColor(Color(.black))
                                    .padding()
                            }
                        } else {
                            Button {
                                //TODO: 음성녹음 띄우기
                            } label: {
                                Image(systemName: "mic")
                                    .foregroundColor(Color(.black))
                                    .padding()
                            }
                        }
                    }
                )
                .onTapGesture {
                    self.editText = true
                }
        }
        .padding(EdgeInsets(top: 5, leading: 15, bottom: 5, trailing: 15))
    }
}
