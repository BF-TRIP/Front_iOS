//
//  CourseDetailNotificationView.swift
//  BF_TRIP
//
//  Created by 박동재 on 3/15/25.
//

import SwiftUI

struct CourseDetailNotificationView: View {
    
    private var notificationList: [String] = [
        "고령자를 위한 이동 편의",
        "지체장애인을 위한 접근성 강화",
        "임산부를 위한 안전 고려",
        "시각장애인을 위한 직관성 고려",
        "청각장애인의 손쉬운 소통 고려",
        "사용자 맞춤형 관광 코스 고려"
    ]
    
    private var list: [Int]
    
    private let notificationFontColor = "184EA7"
    private let notificationBackgroundColor = "E4F8FF"
    
    private let fontSize: CGFloat = 14
    
    init(list: [Int]) {
        self.list = list
    }
    
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text("💡 다음을 고려했어요")
                    .font(.system(size: fontSize, weight: .semibold))
                    .foregroundColor(Color(hex: "\(notificationFontColor)"))
                    .padding(.bottom, 5)
                
                ForEach(list, id: \.self) { index in
                    if index < 6 {
                        Text("\(notificationList[index])")
                            .font(.system(size: fontSize, weight: .semibold))
                    }
                }
            }
            .padding()
            
            Spacer()
        }
        .frame(maxWidth: .infinity)
        .background(
            RoundedRectangle(cornerRadius: 10)
                .fill(Color(hex: "\(notificationBackgroundColor)"))
        )
        .clipShape(RoundedRectangle(cornerRadius: 10))
    }
}
