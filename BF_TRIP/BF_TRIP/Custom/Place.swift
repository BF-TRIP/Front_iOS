//
//  Place.swift
//  BF-TRIP
//
//  Created by 박동재 on 9/29/24.
//

import SwiftUI

struct Place: View {
    private let place: ResponsePlaceDTO
    
    init(place: ResponsePlaceDTO) {
        self.place = place
    }
    
    var body: some View {
        VStack {
            if let urlString = place.originalImage,
               let url = URL(string: urlString) {
                AsyncImage(url: url) { image in
                    image.image?.resizable()
                }
                    .frame(maxWidth: .infinity, minHeight: 148, maxHeight: 148)
                    .background(Color(.white))
                    .clipped()
            } else {
                Image(systemName: "book")
                    .frame(maxWidth: .infinity, minHeight: 148)
                    .background(Color(.white))
                    .clipped()
            }
            
            HStack {
                Text("\(place.contentTitle)")
                    .font(.system(size: 22))
                    .fontWeight(.bold)
                    .foregroundColor(Color(.black))
                
                Text("\(place.addr)")
                    .font(.system(size: 14))
                    .foregroundColor(Color(.black))
                
                Spacer()
                
                Button {
                    //TODO: 관광지 저장 + 통신
                } label: {
                    Image(systemName: "bookmark")
                        .foregroundColor(Color(.label))
                }
            }
            .padding(EdgeInsets(top: 0, leading: 15, bottom: 0, trailing: 15))
            
            HStack {
                Spacer()
                
                Image(uiImage: .physical)
                    .frame(width: 36, height: 36)
                
                Spacer()
                
                Image(uiImage: .senior)
                    .frame(width: 36, height: 36)
                
                Spacer()
                
                Image(uiImage: .wheelChair)
                    .frame(width: 36, height: 36)
                
                Spacer()
                
                Image(uiImage: .eye)
                    .frame(width: 36, height: 36)
                
                Spacer()
                
                Image(uiImage: .ear)
                    .frame(width: 36, height: 36)
                
                Spacer()
            }
            .frame(maxWidth: .infinity, maxHeight: 50)
            .background(Color(.white))
            .padding(EdgeInsets(top: 0, leading: 0, bottom: 15, trailing: 0))
            
        }
        .background(.white)
        .cornerRadius(20)
    }
}
