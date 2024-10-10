//
//  PlaceListView.swift
//  BF-TRIP
//
//  Created by 박동재 on 9/29/24.
//

import SwiftUI

struct PlaceListView: View {
    
    
    var title: String = ""
    var searching: Bool = false
    private let stateList: [String] = ["전체", "휠체어 & 고령자", "시각장애", "청각장애", "임산부 & 영유아"]
    @State var selectedStates = [Int]()
    
    @State private var isPlaceFilterViewShowing: Bool = false
    @Binding var isPlaceListViewShowing: Bool
    
    @ObservedObject var viewModel: MapViewModel
    @StateObject var saveViewModel: PlaceViewModel = PlaceViewModel()
    
    var body: some View {
        VStack {
            HStack {
                if searching {
                    Button {
                        self.isPlaceListViewShowing = false
                    } label: {
                        Image(systemName: "chevron.backward")
                            .foregroundColor(Color(.label))
                    }
                }
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
                selectedComponents: $selectedStates,
                list: stateList,
                backgroundColor: "#393939",
                fontColor: "#FFE023",
                radiusColor: "#000000"
            )
            
            let list = viewModel.seperateList(selectedStates: self.selectedStates)
            List(0..<list.count, id: \.self) { index in
                Place(place: list[index], viewModel: saveViewModel)
                    .padding(EdgeInsets(top: 10, leading: 0, bottom: 10, trailing: 0))
                    .listRowSeparator(.hidden)
                    .shadow(radius: 2)
            }
            .scrollIndicators(.hidden)
            .listStyle(PlainListStyle())
        }
        .fullScreenCover(isPresented: $isPlaceFilterViewShowing, content: {
            PlaceFilterView(
                isPlaceFilterViewShowing: $isPlaceFilterViewShowing,
                viewModel: self.viewModel)
        })
        .transaction { transaction in
            transaction.disablesAnimations = true
        }
        .onAppear(perform: {
            self.saveViewModel.requestList()
        })
        
    }
    
}
