//
//  PlaceFilterView.swift
//  BF_TRIP
//
//  Created by 박동재 on 10/7/24.
//

import SwiftUI

struct PlaceFilterView: View {
    
    @Binding var isPlaceFilterViewShowing: Bool
    @ObservedObject var viewModel: MapViewModel
    
    private let filterList: [String] = ["휠체어 & 고령자 관련", "시각 관련", "청각 관련", "임산부 & 영유아 관련"]
    private let detailfilters: [[String]] = [
        ["전체", "휠체어 이용 가능", "휠체어 대여", "엘리베이터", "장애인 화장실"],
        ["전체", "보조견 동반 가능", "점자 블록", "오디오 가이드"],
        ["전체", "수화 안내", "자막 안내"],
        ["전체", "유모차 대여", "수유실", "유아용 보조의자"],
    ]
    
    @State var selectedStates: [[Int]] = [
        [], [], [], []
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
                    selectedComponents: $selectedStates[index],
                    list: detailfilters[index],
                    backgroundColor: "#FFFCE7",
                    fontColor: "000000",
                    radiusColor: "#FFE838")
                
                Spacer()
            }
            
            Spacer()
            Spacer()
            HStack {
                Button {
                    self.viewModel.revertList()
                    self.selectedStates = [ [], [], [], [] ]
                } label: {
                    Text("초기화")
                        .frame(maxWidth: .infinity, maxHeight: 50)
                        .foregroundColor(Color(.label))
                }
                .disabled(self.selectedStates.allSatisfy { $0.isEmpty })
                .buttonStyle(.plain)
                .background(self.selectedStates.allSatisfy { $0.isEmpty } ? Color(.white) : Color(hex: "#FFE023"))
                .overlay(RoundedRectangle(cornerRadius: 10)
                    .stroke(lineWidth: 1)
                    .foregroundColor(
                        self.selectedStates.allSatisfy { $0.isEmpty } ? Color(hex: "#AAAAAA") : Color(hex: "#FFE023")
                    )
                )
                .cornerRadius(10)
                .padding(EdgeInsets(top: 10, leading: 20, bottom: 10, trailing: 5))
                
                Button {
                    self.viewModel.revertList()
                    self.viewModel.changeList(list: self.viewModel.seperateList(selectedStates: selectedStates))
                    self.isPlaceFilterViewShowing = false
                } label: {
                    Text("적용하기")
                        .frame(maxWidth: .infinity, maxHeight: 50)
                        .foregroundColor(Color(.label))
                }
                .buttonStyle(.plain)
                .background(Color(hex: "#FFE023"))
                .cornerRadius(10)
                .padding(EdgeInsets(top: 10, leading: 5, bottom: 10, trailing: 20))
            }
        }
    }
}
