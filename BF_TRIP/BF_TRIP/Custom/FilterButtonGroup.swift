//
//  FilterButtonGroup.swift
//  BF_TRIP
//
//  Created by 박동재 on 10/7/24.
//

import SwiftUI

struct FilterButtonGroup: View {
    
    @State var selectedComponents: [Int] = []
    let list: [String]
    let backgroundColor: String
    let fontColor: String
    let radiusColor: String
        
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                ForEach(0..<list.count, id: \.self) { index in
                    Button {
                        if self.selectedComponents.contains(index) {
                            self.selectedComponents.removeAll { $0 == index }
                        } else {
                            if index == 0 || self.selectedComponents.contains(0) {
                                self.selectedComponents.removeAll()
                                self.selectedComponents.append(index)
                            } else {
                                self.selectedComponents.append(index)
                            }
                        }
                        dump(self.selectedComponents)
                    } label: {
                        Text("\(self.list[index])")
                            .font(.system(size: 14))
                            .foregroundStyle(self.selectedComponents.contains(index) == true ? Color(hex: "\(fontColor)") : Color(.label))
                            .padding(EdgeInsets(top: 5, leading: 15, bottom: 5, trailing: 15))
                    }
                    .background(self.selectedComponents.contains(index) ? Color(hex: "\(backgroundColor)") : Color(.clear))
                    .cornerRadius(100)
                    .overlay(RoundedRectangle(cornerRadius: 100)
                        .stroke(lineWidth: 1)
                        .foregroundColor(self.selectedComponents.contains(index) ? Color(hex: "\(radiusColor)") : Color(.black))
                    )
                    .padding(EdgeInsets(top: 5, leading: 2, bottom: 5, trailing: 2))
                }
            }
        }
        .padding(EdgeInsets(top: 0, leading: 15, bottom: 0, trailing: 15))
    }

}

#Preview {
    FilterButtonGroup(
        list: ["1", "2"],
        backgroundColor: "#393939", 
        fontColor: "#FFE023",
        radiusColor: "#000000"
    )
}
