//
//  PlaceListView.swift
//  BF-TRIP
//
//  Created by 박동재 on 9/29/24.
//

import SwiftUI

struct PlaceListView: View {
    
    var body: some View {
        VStack {
            HStack {
                Text("관광지 목록")
                    .font(.system(size: 20))
                    .fontWeight(.bold)
                    .foregroundColor(Color(.label))
                
                Spacer()
                
                Button {
                    dump("FILTER")
                } label: {
                    Image(systemName: "slider.vertical.3")
                        .foregroundColor(Color(.label))
                        .frame(width: 24, height: 24)
                }

            }
            .padding()
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    //TODO: 누를때 색 변경, 컴포넌트화 추후 개발
                    Button {
                    
                    } label: {
                        Text("전체")
                            .font(.system(size: 14))
                            .foregroundColor(Color(.label))
                            .padding(EdgeInsets(top: 5, leading: 15, bottom: 5, trailing: 15))
                    }
                    .overlay(RoundedRectangle(cornerRadius: 100)
                        .stroke(lineWidth: 1)
                    )
                    .padding(EdgeInsets(top: 5, leading: 2, bottom: 5, trailing: 2))
                    
                    Button {
                    
                    } label: {
                        Text("지체장애")
                            .font(.system(size: 14))
                            .foregroundColor(Color(.label))
                            .padding(EdgeInsets(top: 5, leading: 15, bottom: 5, trailing: 15))
                    }
                    .overlay(RoundedRectangle(cornerRadius: 100)
                        .stroke(lineWidth: 1)
                    )
                    .padding(EdgeInsets(top: 5, leading: 2, bottom: 5, trailing: 2))
                    
                    Button {
                    
                    } label: {
                        Text("고령자")
                            .font(.system(size: 14))
                            .foregroundColor(Color(.label))
                            .padding(EdgeInsets(top: 5, leading: 15, bottom: 5, trailing: 15))
                    }
                    .overlay(RoundedRectangle(cornerRadius: 100)
                        .stroke(lineWidth: 1)
                    )
                    .padding(EdgeInsets(top: 5, leading: 2, bottom: 5, trailing: 2))
                    
                    Button {
                    
                    } label: {
                        Text("시각장애")
                            .font(.system(size: 14))
                            .foregroundColor(Color(.label))
                            .padding(EdgeInsets(top: 5, leading: 15, bottom: 5, trailing: 15))
                    }
                    .overlay(RoundedRectangle(cornerRadius: 100)
                        .stroke(lineWidth: 1)
                    )
                    .padding(EdgeInsets(top: 5, leading: 2, bottom: 5, trailing: 2))
                    
                    Button {
                    
                    } label: {
                        Text("영유아 동반자")
                            .font(.system(size: 14))
                            .foregroundColor(Color(.label))
                            .padding(EdgeInsets(top: 5, leading: 15, bottom: 5, trailing: 15))
                    }
                    .overlay(RoundedRectangle(cornerRadius: 100)
                        .stroke(lineWidth: 1)
                    )
                    .padding(EdgeInsets(top: 5, leading: 2, bottom: 5, trailing: 2))
                    
                }
            }
            .padding(EdgeInsets(top: 0, leading: 15, bottom: 0, trailing: 15))
            

            List(0..<5) {_ in
                PlaceView()
                    .padding(EdgeInsets(top: 10, leading: 0, bottom: 10, trailing: 0))
            }
            .scrollIndicators(.hidden)
            .listStyle(PlainListStyle())
        }
    }
    
}

#Preview {
    PlaceListView()
}
