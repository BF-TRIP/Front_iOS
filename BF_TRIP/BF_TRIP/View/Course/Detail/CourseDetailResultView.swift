//
//  CourseDetailResultView.swift
//  BF_TRIP
//
//  Created by 박동재 on 3/15/25.
//

import SwiftUI

struct CourseDetailResultView: View {
    
    @State private var selectedList: [ResponsePlaceDTO] = []
    @State private var selectedNumber: Int = 1
    
    @Binding var course: CourseModel
    @Binding var isDetailShowing: Bool

    @State private var draw: Bool = true
    
    @State private var offset: CGFloat = 0
    @State private var lastOffset: CGFloat = 0
    @GestureState var gestureOffset: CGFloat = 0

    @State private var gpsX: Double = 127
    @State private var gpsY: Double = 38
    
    var body: some View {
        ZStack {
            KakaoMapView(
                draw: $draw,
                gpsY: $gpsY,
                gpsX: $gpsX,
                list: $selectedList
            )
            .onAppear {
                self.draw = true
            }
            .onDisappear{
                self.draw = false
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .ignoresSafeArea()
            
            VStack {
                HStack {
                    Button {
                        self.isDetailShowing.toggle()
                    } label: {
                        Image(uiImage: .back)
                            .frame(width: 44, height: 44)
                            .contentShape(Rectangle())
                    }
                    .padding(.top, 20)
                    .padding(.leading, 20)
                    
                    Spacer()
                }
                Spacer()
            }
            
            GeometryReader { proxy -> AnyView in
                let availableHeight = proxy.size.height
                // 2. maxHeight를 사용 가능한 전체 높이로 설정 ('- 100' 제거)
                let maxHeight = availableHeight

                // 스냅 포인트 정의 (새 maxHeight 기준, 비율 유지)
                let fullOpenOffset: CGFloat = -maxHeight
                // 필요시 비율 조정 (예: 중간 지점을 50%로 유지)
                let partialOpenOffset: CGFloat = -(maxHeight * 0.5) // 비율로 재정의
                let peekOpenOffset: CGFloat = -(maxHeight * 0.15)   // 비율로 재정의

                // 스냅 임계값 정의 (비율 기반 유지)
                let threshold1 = maxHeight * 0.25 // 예: 25% 기준
                let threshold2 = maxHeight * 0.6  // 예: 60% 기준

                AnyView(
                    CourseDetailBottomSheetView(
                        offset: $offset,
                        course: $course,
                        selectedList: $selectedList,
                        selectedNumber: $selectedNumber,
                        height: maxHeight
                    )
                    .offset(y: maxHeight)
                    .offset(y: -offset > 0 ? (-offset <= maxHeight ? offset : fullOpenOffset) : 0)
                    .gesture(DragGesture().updating($gestureOffset, body: { value, out, _ in
                        out = value.translation.height
                        
                        onBottomSheetChange()
                    }).onEnded({ value in
                        let finalDraggedOffset = lastOffset + value.translation.height
                        let visibleHeight = -finalDraggedOffset

                        withAnimation(.interactiveSpring()) {
                            if visibleHeight < threshold1 {
                                offset = peekOpenOffset
                            } else if visibleHeight < threshold2 {
                                offset = partialOpenOffset
                            } else {
                                offset = fullOpenOffset
                            }
                        }
                        lastOffset = offset
                    }))
//                    .edgesIgnoringSafeArea(.bottom)
                    .onAppear {
                         self.offset = partialOpenOffset
                         lastOffset = offset

                         if !course.locationInfoResList.isEmpty {
                            selectedList = course.locationInfoResList[0]
                         }
                    }
                )
            }
            .ignoresSafeArea(.container, edges: .bottom)
        }
    }
    
}

private extension CourseDetailResultView {
    
    func onBottomSheetChange() {
        Task {
            await MainActor.run {
                self.offset = gestureOffset + lastOffset
            }
        }
    }
    
}
