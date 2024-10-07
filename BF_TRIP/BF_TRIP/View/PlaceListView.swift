//
//  PlaceListView.swift
//  BF-TRIP
//
//  Created by 박동재 on 9/29/24.
//

import SwiftUI

struct PlaceListView: View {
    
    private let stateList: [String] = ["전체", "지체장애", "고령자", "영유아동반자", "시각장애", "청각장애"]
    @State private var selectedStateList: [Bool] = [false, false, false, false, false, false,]
    @State private var selectedStates = [Int]()
    
    @ObservedObject var viewModel: MapViewModel
    
    init(viewModel: MapViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        VStack {
            HStack {
                Text("관광지 목록")
                    .font(.system(size: 20))
                    .fontWeight(.bold)
                    .foregroundColor(Color(.label))
                
                Spacer()
                
                Button {
                    dump("FILTER")
                } label: {
                    Image(systemName: "slider.vertical.3")
                        .foregroundColor(Color(.label))
                        .frame(width: 24, height: 24)
                }
                
            }
            .padding()
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    ForEach(0..<stateList.count, id: \.self) { index in
                        Button {
                            if self.selectedStates.contains(index) {
                                self.selectedStates.removeAll { $0 == index }
                            } else {
                                self.selectedStates.append(index)
                            }
                        } label: {
                            Text("\(self.stateList[index])")
                                .font(.system(size: 14))
                                .foregroundStyle(self.selectedStates.contains(index) == true ? Color(hex: "#FFE023") : Color(.label))
                                .padding(EdgeInsets(top: 5, leading: 15, bottom: 5, trailing: 15))
                        }
                        .background(self.selectedStates.contains(index) ? Color(hex: "#393939") : Color(.clear))
                        .cornerRadius(100)
                    }
                    .overlay(RoundedRectangle(cornerRadius: 100)
                        .stroke(lineWidth: 1)
                    )
                    .padding(EdgeInsets(top: 5, leading: 2, bottom: 5, trailing: 2))
                }
            }
            .padding(EdgeInsets(top: 0, leading: 15, bottom: 0, trailing: 15))
            
            List(0..<viewModel.placeList.count, id: \.self) { index in
                Place(place: viewModel.placeList[index])
                    .padding(EdgeInsets(top: 10, leading: 0, bottom: 10, trailing: 0))
                    .listRowSeparator(.hidden)
                    .shadow(radius: 2)
            }
            .scrollIndicators(.hidden)
            .listStyle(PlainListStyle())
        }
        .padding(EdgeInsets(top: 0, leading: 0, bottom: 100, trailing: 0))
        
    }
    
}
