//
//  SearchFilterView.swift
//  BF-TRIP
//
//  Created by 박동재 on 9/28/24.
//

import SwiftUI

struct SearchFilterView: View {
    @Binding var isFilterViewShowing: Bool
    
    var body: some View {
        VStack {
            HStack {
                Button {
                    self.isFilterViewShowing = false
                } label: {
                    Image(systemName: "chevron.backward")
                        .foregroundColor(Color(.black))
                }
                .padding()
                
                Spacer()
            }
            
            Spacer()
            
            Text("원하는 여행지의")
                .fontWeight(.bold)
                .font(.system(size: 24))
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(EdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 0))
            Text("위치를 검색해주세요")
                .fontWeight(.bold)
                .font(.system(size: 24))
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(EdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 0))
            
            Spacer()
            
            HStack {
                //TODO: 지역, 상세지역 리스트 만들어서 적용
                //TODO: 눌렀을 때, 애니메이션이랑 색 변경
                List(0..<8) { i in
                    Text("\(i)")
                        .listRowBackground(Color(.systemGray5))
                }
                .listStyle(PlainListStyle())
                .frame(width: 120, height: 400)
                .scrollDisabled(true)
                List(0..<30) { i in
                    Text("\(i)")
                }
                .listStyle(PlainListStyle())
                .frame(width: 240, height: 400)
                .scrollBounceBehavior(.basedOnSize)
            }
            .frame(height: 400)
            
            Spacer()
            
            HStack {
                Button {
                    //TODO: 지역, 상세지역 저장하고 전달
                    dump("ACCEPT")
                    self.isFilterViewShowing = false
                } label: {
                    Text("적용하기")
                        .frame(maxWidth: .infinity, maxHeight: 53)
                        .foregroundColor(Color(.black))
                        .fontWeight(.bold)
                }
                .buttonStyle(.plain)
                .background(Color(hex: "#FFE023"))
                .cornerRadius(10)
                .padding(EdgeInsets(top: 10, leading: 30, bottom: 10, trailing: 30))
            }

        }
    }
}
