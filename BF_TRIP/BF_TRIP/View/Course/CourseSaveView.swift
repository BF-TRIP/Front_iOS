//
//  CourseSaveView.swift
//  BF_TRIP
//
//  Created by 박동재 on 3/3/25.
//

import SwiftUI

struct CourseSaveView: View {
    @Binding var isSaving: Bool
    @Binding var isResultShowing: Bool
    
    @State private var text: String = ""
    @State private var date = Date()
    
    var body: some View {
        NavigationStack {
            ZStack {
                HStack {
                    Button(action: { isSaving.toggle() }) {
                        Image(systemName: "chevron.backward")
                            .foregroundColor(.black)
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
                TextField("코스의 제목을 만들어주세요. (ex) 가족여행)", text: self.$text)
                    .autocorrectionDisabled()
                    .padding()
                    .background(
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
                
                Button(action: saveCourse) {
                    Text("저장")
                        .frame(maxWidth: .infinity, maxHeight: 55)
                        .foregroundColor(.white)
                        .font(.system(size: 20, weight: .bold))
                        .background(text.isEmpty ? Color(hex: "#D9D9D9") : Color(hex: "#1650A9"))
                        .cornerRadius(10)
                }
                .disabled(text.isEmpty)
            }
            .padding()
            
            Spacer()
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
