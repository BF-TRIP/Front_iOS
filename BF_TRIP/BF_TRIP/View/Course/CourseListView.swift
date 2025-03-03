//
//  CourseListView.swift
//  BF_TRIP
//
//  Created by 박동재 on 3/3/25.
//

import SwiftUI

struct CourseListView: View {
    
    @Binding var course: CourseModel
    @Binding var selectedDay: Int
    
    @Binding var dayOneList: [Course]
    @Binding var dayTwoList: [Course]
    @Binding var dayThreeList: [Course]
    
    @Binding var selectedList: [Course]
    @Binding var selectedNumber: Int
    
    @State private var isWebViewShowing = false
    @State private var isOnboarding = false
    
    var body: some View {
        VStack {
            ForEach($selectedList, id: \.self) { day in
                CourseRow(day: day)
            }
            .onDelete(perform: deleteItem)
            .onMove(perform: moveItem)
            .onTapGesture {
                isOnboarding.toggle()
            }
            .onChange(of: selectedNumber) { _, newValue in
                updateSelectedList(for: newValue)
            }
            .fullScreenCover(isPresented: $isOnboarding) {
//                CourseWebView(isOnboarding: $isOnboarding)
            }
        }
    }
}

private extension CourseListView {
    func deleteItem(at offsets: IndexSet) {
        selectedList.remove(atOffsets: offsets)
    }
    
    func moveItem(from source: IndexSet, to destination: Int) {
        selectedList.move(fromOffsets: source, toOffset: destination)
    }
    
    func updateSelectedList(for dayNumber: Int) {
        switch dayNumber {
        case 1:
            selectedList = dayOneList
        case 2:
            selectedList = dayTwoList
        case 3:
            selectedList = dayThreeList
        default:
            break
        }
    }
}

struct CourseRow: View {
    @Binding var day: Course
    
    var body: some View {
        HStack {
            VStack {
                ZStack(alignment: .center) {
                    Image(uiImage: .placeMarker)
                        .resizable()
                        .scaledToFit()
                    Text(" ")
                        .font(.system(size: 12))
                        .foregroundColor(.white)
                        .padding(.bottom, 3)
                }
                .frame(height: 28)
                
                Image(uiImage: .dotLine)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(height: 40)
            }
            
            CourseView(day: $day)
                .cornerRadius(15)
                .overlay(
                    RoundedRectangle(cornerRadius: 15)
                        .stroke(lineWidth: 0.2)
                        .foregroundColor(.gray)
                )
        }
        .listRowSeparator(.hidden)
    }
}
