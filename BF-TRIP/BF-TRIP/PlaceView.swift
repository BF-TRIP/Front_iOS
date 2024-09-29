//
//  PlaceView.swift
//  BF-TRIP
//
//  Created by 박동재 on 9/29/24.
//

import SwiftUI

struct PlaceView: View {
    var body: some View {
        VStack {
            HStack {
                Text("창경궁")
                    .font(.system(size: 22))
                    .fontWeight(.bold)
                
                Text("서울 종로구 창경궁로 185")
                    .font(.system(size: 14))
                
                Spacer()
                
                Button {
                    //TODO: 관광지 저장 + 통신
                    dump("SAVE")
                } label: {
                    Image(systemName: "bookmark")
                        .foregroundColor(Color(.label))
                }
            }
            .padding(EdgeInsets(top: 15, leading: 15, bottom: 0, trailing: 15))
            
            Image(systemName: "book")
                .frame(maxWidth: .infinity, minHeight: 120)
                .background(Color(.white))
                .cornerRadius(15)
                .padding(EdgeInsets(top: 0, leading: 15, bottom: 0, trailing: 15))
            
            HStack {
                Spacer()
                
                Image(systemName: "1.square.fill")
                    .frame(width: 36, height: 36)
                    .background(Color(hex: "#D9D9D9"))
                
                Spacer()
                
                Image(systemName: "2.square.fill")
                    .frame(width: 36, height: 36)
                    .background(Color(hex: "#D9D9D9"))
                
                Spacer()
                
                Image(systemName: "3.square.fill")
                    .frame(width: 36, height: 36)
                    .background(Color(hex: "#D9D9D9"))
                
                Spacer()
                
                Image(systemName: "4.square.fill")
                    .frame(width: 36, height: 36)
                    .background(Color(hex: "#D9D9D9"))
                
                Spacer()
                
                Image(systemName: "5.square.fill")
                    .frame(width: 36, height: 36)
                    .background(Color(hex: "#D9D9D9"))
                
                Spacer()
            }
            .frame(maxWidth: .infinity, maxHeight: 50)
            .background(Color(.white))
            .cornerRadius(15)
            .padding(EdgeInsets(top: 0, leading: 15, bottom: 15, trailing: 15))
            
        }
        .background(Color(hex: "#D9D9D9"))
        .cornerRadius(15)
    }
}

#Preview {
    PlaceView()
        .previewLayout(.sizeThatFits)
}
