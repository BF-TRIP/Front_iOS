//
//  PlaceFilterView.swift
//  BF_TRIP
//
//  Created by 박동재 on 10/7/24.
//

import SwiftUI

struct PlaceFilterView: View {
    
    @Binding var isPlaceFilterViewShowing: Bool
    
    private let filterList: [String] = ["휠체어 & 고령자 관련", "시각 관련", "청각 관련", "영유아 관련"]
    private let detailfilters: [[String]] = [
        ["전체", "휠체어 가능", "휠체어 대여", "엘리베이터", "장애인 화장실"],
        ["전체", "보조견 동반 가능", "점자 블록", "오디오 가이드"],
        ["전체", "수화 안내", "자막 안내"],
        ["전체", "유모차 대여", "수유실", "유아용 보조의자"],
    ]
    
    var body: some View {
        VStack {
            HStack {
                Text("베리어프리 시설물 필터")
                    .font(.system(size: 20))
                    .fontWeight(.bold)
                    .foregroundColor(Color(.label))
                
                Spacer()
                
                Button {
                    self.isPlaceFilterViewShowing = false
                } label: {
                    Image(systemName: "xmark")
                        .foregroundColor(Color(.label))
                        .frame(width: 24, height: 24)
                }
            }
            .padding()
            
            ForEach(0..<filterList.count, id: \.self) { index in
                Text("\(filterList[index])")
                    .font(.system(size: 16))
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(EdgeInsets(top: 20, leading: 15, bottom: 0, trailing: 0))
                FilterButtonGroup(
                    list: detailfilters[index],
                    backgroundColor: "#FFE54A",
                    fontColor: "000000",
                    radiusColor: "#FFE838")
                
                Spacer()
            }
            
            Spacer()
            Spacer()
        }
    }
}
