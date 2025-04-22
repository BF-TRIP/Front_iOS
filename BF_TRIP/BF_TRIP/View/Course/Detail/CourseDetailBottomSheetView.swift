//
//  CourseDetailBottomSheetView.swift
//  BF_TRIP
//
//  Created by 박동재 on 3/15/25.
//

import SwiftUI

struct CourseDetailBottomSheetView: View {

    @Binding var offset: CGFloat
    @Binding var course: CourseModel // Assuming CourseModel is defined elsewhere
    @Binding var selectedList: [ResponsePlaceDTO] // Assuming ResponsePlaceDTO is defined elsewhere
    @Binding var selectedNumber: Int
    let height: CGFloat

    var body: some View {
        // 1. 루트 뷰를 VStack으로 변경
        VStack(spacing: 0) {

            // 2. 드래그 핸들 영역
            VStack {
                Capsule()
                    // .fill(Color.Black) // 시스템 또는 디자인 시스템 색상 추천
                    .fill(Color(UIColor.systemGray3)) // 예시: 시스템 회색 사용
                    .frame(width: 40, height: 5) // 핸들 크기 조정
                    .padding(.vertical, 10) // 핸들 상하 여백
            }
            .frame(maxWidth: .infinity) // 핸들 영역 너비 최대로

            // 3. 콘텐츠 영역 (CourseDetailSegmentView)
            CourseDetailSegmentView(
                course: $course,
                selectedList: $selectedList,
                selectedNumber: $selectedNumber
            )
            // CourseDetailSegmentView가 남은 공간을 모두 사용하도록 함
            // 중요: CourseDetailSegmentView 내부에 스크롤 가능한 콘텐츠가 있을 수 있음

        }
        // 4. 전체 바텀 시트 크기 및 모양 설정
        .frame(maxWidth: .infinity) // 너비 최대로
        .frame(height: height)      // 부모로부터 받은 높이 설정
        // 5. 여기에 배경 추가 (핵심 수정!)
        .background(backgroundColor) // 아래 정의된 배경 스타일 적용
        // 6. 전체 VStack에 둥근 모서리 적용
        .clipShape(CustomCorner(corners: [.topLeft, .topRight], radius: 30)) // 상단 모서리만
    }

    // 배경 스타일 정의 (일관성을 위해 MapBottomSheetView와 동일하게 유지 권장)
    private var backgroundColor: some View {
        // 필요에 따라 선택:
        // 1. 시스템 기본 배경 (라이트/다크 모드 자동 대응)
         Color(UIColor.systemBackground)

        // 2. 반투명 블러 효과 (머티리얼)
        // .regularMaterial

        // 3. 디자인 시스템 커스텀 색상
        // Color.appBottomSheetBackground
    }
}

extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape( CustomCorner(corners: corners, radius: radius) )
    }
}
