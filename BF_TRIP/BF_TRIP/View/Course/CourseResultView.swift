//
//  CourseResultView.swift
//  BF_TRIP
//
//  Created by 박동재 on 3/3/25.
//

import SwiftUI

struct CourseResultView: View {
    @State private var dayList: [[ResponsePlaceDTO]] = [[]]
    @State private var draw = true
    @State private var isSaving = false
    @State private var selectedDay = 0
    @State private var selectedList: [ResponsePlaceDTO] = []
    
    @Binding var isResultShowing: Bool
    @Binding var result: CourseModel
    
    @State private var showAlert = false
    
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
                
                CourseInfoView(course: $result)
                    .padding(.top)
                
                KakaoMapView(draw: $draw, gpsY: $gpsY, gpsX: $gpsX, list: $dayList[0])
                    .frame(height: 200)
                    .onAppear { draw = true }
                    .onDisappear { draw = false }
                
                DaysComponent(
                    course: $result,
                    selectedDay: $selectedDay,
                    backgroundColor: Constants.backgroundColor,
                    defalutColor: Constants.defaultColor,
                    fontColor: Constants.fontColor
                )
                .padding(.leading, 30)
                .padding(.top, 10)
                
                CourseListView(
                    course: $result,
                    selectedDay: $selectedDay,
                    selectedList: $selectedList
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
            .onAppear {
                selectedDay = 1
                selectedList = result.locationInfoResList[0]
            }
            .background(Color.white)
        }
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
    @Binding var course: CourseModel
    
    var body: some View {
        VStack(spacing: 3) {
            HStack(spacing: 8) {
                Text(course.courseInfo.area ?? "")
                    .font(.system(size: Constants.semiboldFontSize, weight: .semibold))
                    .foregroundColor(.black)
                
                if course.locationInfoResList.count == 1 {
                    Text("당일치기")
                        .font(.system(size: Constants.semiboldFontSize, weight: .semibold))
                        .foregroundColor(.black)
                } else {
                    Text("\(course.locationInfoResList.count - 1)박 \(course.locationInfoResList.count)일")
                        .font(.system(size: Constants.semiboldFontSize, weight: .semibold))
                        .foregroundColor(.black)
                }
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
