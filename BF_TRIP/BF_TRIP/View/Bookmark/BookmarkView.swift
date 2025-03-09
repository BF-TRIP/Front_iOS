//
//  BookmarkView.swift
//  BF_TRIP
//
//  Created by 박동재 on 10/4/24.
//

import SwiftUI

struct BookmarkView: View {
    
    @State private var selectedSegment = 0
    
    @State private var places: [ResponsePlaceDTO] = []
    @State private var courses: [ResponsePlaceDTO] = []
    
    @Binding var userId: Int?
    
    var body: some View {
        VStack {
            Text("저장")
                .font(.system(size: 22, weight: .bold))
                .foregroundColor(.black)
                .padding(.top)
                .padding(.leading)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            Picker("Segments", selection: $selectedSegment) {
                Text("관광지").tag(0)
                Text("코스").tag(1)
            }
            .padding()
            .pickerStyle(SegmentedPickerStyle())
            
            if selectedSegment == 0 {
                List(0..<places.count, id: \.self) { index in
                    SavePlaceView(place: $places[index])
                        .padding(EdgeInsets(top: 5, leading: 0, bottom: 5, trailing: 0))
                        .listRowSeparator(.hidden)
    //                    .shadow(radius: 2)
                }
                .scrollIndicators(.hidden)
                .listStyle(PlainListStyle())
            } else if selectedSegment == 1 {
                //TODO: 저장된 코스 목록
            }
            
            Spacer()
        }
        .background(Color.white.edgesIgnoringSafeArea(.all))
        .task {
            await fetchSavePlaceList()
        }
    }
    
    private func fetchSavePlaceList() async {
        do {
            places = try await MoyaManager.shared.getSavePlaceList(userNumber: userId ?? 0)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    private func fetchSaveCourseList() async {
        do {
            courses = try await MoyaManager.shared.getSaveCourseList(userNumber: userId ?? 0)
        } catch {
            print(error.localizedDescription)
        }
    }

}
