//
//  PlaceListView.swift
//  BF-TRIP
//
//  Created by 박동재 on 9/29/24.
//

import SwiftUI

struct PlaceListView: View {
    
    
    private var title: String = ""
    private let stateList: [String] = ["전체", "지체장애", "고령자", "영유아동반자", "시각장애", "청각장애"]
    @State private var selectedStateList: [Bool] = [false, false, false, false, false, false,]
    @State private var selectedStates = [Int]()
    
    @State var isPlaceFilterViewShowing: Bool = false
    
    @ObservedObject var viewModel: MapViewModel
    
    init(title: String, viewModel: MapViewModel) {
        self.title = title
        self.viewModel = viewModel
    }
    
    var body: some View {
        VStack {
            HStack {
                Text("\(title)")
                    .font(.system(size: 20))
                    .fontWeight(.bold)
                    .foregroundColor(Color(.label))
                
                Spacer()
                
                Button {
                    self.isPlaceFilterViewShowing = true
                } label: {
                    Image(systemName: "slider.vertical.3")
                        .foregroundColor(Color(.label))
                        .frame(width: 24, height: 24)
                }
                
            }
            .padding()
            
            FilterButtonGroup(
                list: stateList,
                backgroundColor: "#393939",
                fontColor: "#FFE023",
                radiusColor: "#000000"
            )
            
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
        .fullScreenCover(isPresented: $isPlaceFilterViewShowing, content: {
            PlaceFilterView(isPlaceFilterViewShowing: $isPlaceFilterViewShowing)
        })
        .transaction { transaction in
            transaction.disablesAnimations = true
        }
        
    }
    
}
