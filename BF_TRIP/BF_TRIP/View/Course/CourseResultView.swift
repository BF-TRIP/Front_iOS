//
//  CourseResultView.swift
//  BF_TRIP
//
//  Created by 박동재 on 3/3/25.
//

import SwiftUI

struct CourseResultView: View {
    @State private var dayList: [[Course]] = [[]]
    @State private var draw = true
    @State private var isSaving = false
    @State private var selectedDay = 0
    @State private var selectedList: [Course] = []
    
    @Binding var isResultShowing: Bool
    @Binding var courseNumber: Int
    
    @State private var showAlert = false
    
    @State private var course: CourseModel = CourseModel(
        courseInfo: CourseInfo(
            courseNumber: 0,
            courseName: "",
            area: "",
            startDate: "",
            endDate: "",
            mobility: false,
            blind: false,
            hear: false,
            family: false
        ),
        locationInfoResList: []
    )
    
    @State private var gpsX: Double = 128
    @State private var gpsY: Double = 37
    
    var body: some View {
        NavigationStack {
            VStack {
                ZStack {
                    HStack {
                        Button(action: { showAlert = true }) {
                            Image(systemName: "xmark")
                                .foregroundColor(.black)
                        }
                        .alert("코스 생성을 취소할까요?", isPresented: $showAlert) {
                            Button("아니요", role: .cancel) { }
                            Button("취소하기", role: .destructive) {
                                isResultShowing = false
                            }
                        }
                        Spacer()
                    }
                    
                    Text("완성된 코스를 확인해보세요")
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundColor(.black)
                }
                .padding()
                
                CourseInfoView(course: course)
                    .padding(.top)
                
                KakaoMapView(draw: $draw, gpsY: $gpsY, gpsX: $gpsX, list: $dayList[0])
                    .frame(height: 200)
                    .onAppear { draw = true }
                    .onDisappear { draw = false }
                
                DaysComponent(
                    selectedDay: $selectedDay,
                    days: 0,
                    backgroundColor: Constants.backgroundColor,
                    defalutColor: Constants.defaultColor,
                    fontColor: Constants.fontColor
                )
                .padding(.leading, 30)
                .padding(.top, 10)
                
                CourseListView(
                    course: $course,
                    selectedDay: $selectedDay
                )
                
                Spacer()
                
                Button(action: { isSaving.toggle() }) {
                    Text("내 코스로 등록하기")
                        .font(.system(size: Constants.floatingFontSize, weight: .semibold))
                }
                .buttonStyle(InsetRoundButton())
            }
            .fullScreenCover(isPresented: $isSaving) {
                CourseSaveView(isSaving: $isSaving, isResultShowing: $isResultShowing)
            }
            .onAppear { setResult() }
            .background(Color.white)
        }
    }
}

private extension CourseResultView {
    func setResult() {
//        MoyaManager.shared.idToCourse(number: courseNumber) { result in
//            switch result {
//            case .success(let data):
//                course = data
//                selectedDay = 1
//                selectedList = data.day1
//            case .failure(let error):
//                print("Error loading course:", error.localizedDescription)
//            }
//        }
    }
}

struct HeaderView: View {
    @Binding var isResultShowing: Bool
    
    var body: some View {
        ZStack {
            HStack {
                Button(action: { isResultShowing.toggle() }) {
                    Image(systemName: "xmark")
                        .foregroundColor(.black)
                }
                Spacer()
            }
            
            Text("완성된 코스를 확인해보세요")
                .font(.system(size: 16, weight: .semibold))
                .foregroundColor(.black)
        }
        .padding()
    }
}

struct CourseInfoView: View {
    let course: CourseModel
    
    var body: some View {
        VStack(spacing: 3) {
            HStack(spacing: 8) {
                Text(course.courseInfo.area ?? "")
                    .font(.system(size: Constants.semiboldFontSize, weight: .semibold))
                    .foregroundColor(.black)
                
                Text("1박 2일")
                    .font(.system(size: Constants.semiboldFontSize, weight: .semibold))
                    .foregroundColor(.black)
            }
            
            Text(Constants.mention)
                .font(.system(size: Constants.mediumFontSize, weight: .medium))
                .foregroundColor(.black)
        }
    }
}

struct Constants {
    static let mention = "더욱 쉽게 접근할 수 있는 코스로 준비했어요"
    
    static let backgroundColor = "0A70C9"
    static let defaultColor = "E2E2E2"
    static let fontColor = "FFFFFF"
    
    static let semiboldFontSize: CGFloat = 24
    static let mediumFontSize: CGFloat = 18
    static let floatingFontSize: CGFloat = 16
}
