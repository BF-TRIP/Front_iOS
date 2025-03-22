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
                let height = proxy.frame(in: .global).height - 100
                
                AnyView(
                    CourseDetailBottomSheetView(
                        offset: $offset,
                        course: $course,
                        selectedList: $selectedList,
                        selectedNumber: $selectedNumber,
                        height: height
                    )
                    .offset(y: height)
                    .offset(y: -offset > 0 ? -offset <= height ? offset : -height : 0)
                    .gesture(DragGesture().updating($gestureOffset, body: { value, out, _ in
                        out = value.translation.height
                        onBottomSheetChange()
                    }).onEnded({ value in
                        withAnimation {
                            if -offset < height / 2 {
                                offset = -(height / 3)
                            } else {
                                offset = -height
                            }
                        }
                        lastOffset = offset
                    }))
                    .edgesIgnoringSafeArea(.bottom)
                    .onAppear {
                        self.offset = -height
                        lastOffset = offset
                        
                        selectedList = course.locationInfoResList[0]    
                    }
                )
            }
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
