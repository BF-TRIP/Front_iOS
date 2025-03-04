//
//  CourseSaveView.swift
//  BF_TRIP
//
//  Created by 박동재 on 3/3/25.
//

import SwiftUI
import Combine

struct CourseSaveView: View {
    
    @Binding var isSaving: Bool
    @Binding var isResultShowing: Bool
    
    @State private var text: String = ""
    @State private var date = Date()
    
    @State private var keyboardHeight: CGFloat = 0
    
    var body: some View {
        NavigationStack {
            ZStack {
                HStack {
                    Button {
                        self.isSaving.toggle()
                    } label: {
                        Image(systemName: "chevron.backward")
                            .foregroundColor(Color(.label))
                    }
                    Spacer()
                }
                .padding()
                
                Text("내 코스로 등록하기")
                    .font(.system(size: 20, weight: .semibold))
            }
            
            VStack {
                HStack {
                    Text("코스 제목 입력")
                        .font(.system(size: 20, weight: .semibold))
                    Spacer()
                }
                TextField("코스의 제목을 만들어주세요. (ex. 가족여행)", text: self.$text)
                    .autocorrectionDisabled()
                    .padding(.top, 15)
                    .padding(.bottom, 15)
                    .padding(.horizontal, 15)
                    .overlay(
                        RoundedRectangle(cornerRadius: 15)
                            .stroke(lineWidth: 1)
                            .foregroundColor(Color(hex: "#F2F2F2"))
                    )
                
                Spacer()
                
                HStack {
                    Text("여행 시작일을 선택해주세요")
                        .font(.system(size: 20, weight: .semibold))
                    Spacer()
                }
                
                DatePicker("Date", selection: $date, displayedComponents: [.date])
                    .datePickerStyle(.wheel)
                    .padding()
                    .labelsHidden()
                
                Spacer()
                Spacer()
                
                HStack {
                    Button {
                        saveCourse()
                    } label: {
                        Text("저장")
                            .font(.system(size: 20, weight: .bold))
                            .frame(width: UIScreen.main.bounds.width * 0.8)
                            .frame(height: UIScreen.main.bounds.height * 0.02)
                    }
                    .buttonStyle(CustomButtonStyle())
                    .disabled(text.isEmpty)
                    .padding(.bottom, keyboardHeight > 0 ? keyboardHeight - 260 : 0)
                }
                .onReceive(Publishers.keyboardHeight) { self.keyboardHeight = $0 }
            }
            .padding()
        }
    }
}

private extension CourseSaveView {
    func saveCourse() {
//        MoyaManager.shared.patchToCourse(
//            number: 25,
//            UUID: Bundle.main.UUID,
//            name: text,
//            date: "2024-12-24"
//        ) { result in
//            switch result {
//            case .success(let data):
//                dump(data)
//            case .failure(let error):
//                dump(error.localizedDescription)
//            }
//        }
        isSaving.toggle()
        isResultShowing.toggle()
    }
}
