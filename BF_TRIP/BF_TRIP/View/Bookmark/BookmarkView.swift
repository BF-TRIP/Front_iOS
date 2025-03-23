//
//  BookmarkView.swift
//  BF_TRIP
//
//  Created by 박동재 on 10/4/24.
//

import SwiftUI

struct BookmarkView: View {
    
    @State private var userNumber: Int = DataManager.shared.loadUserId() ?? 0
    
    @State private var selectedSegment = 0
    
    @State private var places: [ResponsePlaceDTO] = []
    @State private var courses: [CourseInfo] = []
    @State private var course: CourseModel = CourseModel(
        courseInfo: CourseInfo(
            courseNumber: 0,
            courseName: "",
            area: "",
            image: "",
            gpsX: 0.0,
            gpsY: 0.0,
            startDate: "",
            endDate: "",
            mobility: false,
            blind: false,
            hear: false,
            family: false
        ),
        locationInfoResList: []
    )
    
    @State private var selectedCourseNumber: Int?
    @State var isDetailShowing: Bool = false
    
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
            
            ScrollView {
                if selectedSegment == 0 {
                    ForEach($places, id: \.self) { $place in
                        Button {
                            selectedCourseNumber = place.contentId
                        } label: {
                            SavePlaceView(userNumber: $userNumber, places: $places, place: $place)
                        }
                        .padding()
                        .listRowSeparator(.hidden)
                    }
                    .scrollIndicators(.hidden)
                    .listStyle(PlainListStyle())
                } else if selectedSegment == 1 {
                    ForEach($courses, id: \.self) { $course in
                        Button {
                            selectedCourseNumber = course.courseNumber
                            Task {
                                await fetchCourse()
                            }
                        } label: {
                            SaveCourseView(course: $course)
                                .background(.white)
                                .cornerRadius(15)
                                .shadow(radius: 0.5)
                        }
                        .listRowSeparator(.hidden)
                    }
                    .onDelete(perform: { indexSet in
                        courses.remove(atOffsets: indexSet)
                    })
                    .onMove(perform: { indices, newOffset in
                        courses.move(fromOffsets: indices, toOffset: newOffset)
                    })
                    .padding(.top, 10)
                    .padding(.leading)
                    .padding(.trailing)
                }
            }
            .padding(.bottom, 10)
            
            Spacer()
        }
        .background(Color.white.edgesIgnoringSafeArea(.all))
        .task {
            await fetchSavePlaceList()
            await fetchSaveCourseList()
        }
        .fullScreenCover(isPresented: $isDetailShowing, content: {
            CourseDetailResultView(
                course: $course,
                isDetailShowing: $isDetailShowing
            )
        })
    }
    
    private func fetchSavePlaceList() async {
        do {
            places = try await MoyaManager.shared.getSavePlaceList(userNumber: userNumber)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    private func fetchSaveCourseList() async {
        do {
            courses = try await MoyaManager.shared.getSaveCourseList(userNumber: userNumber)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    private func fetchCourse() async {
        do {
            course = try await MoyaManager.shared.getCourseDetail(courseNumber: selectedCourseNumber ?? 0)
            self.isDetailShowing.toggle()
        } catch {
            print(error.localizedDescription)
        }
    }

}
