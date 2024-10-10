//
//  Place.swift
//  BF-TRIP
//
//  Created by 박동재 on 9/29/24.
//

import SwiftUI

struct Place: View {
    private let place: ResponsePlaceDTO
    
    @ObservedObject var viewModel: PlaceViewModel
    @State private var tmpcheck = false;
    
    init(place: ResponsePlaceDTO, viewModel: PlaceViewModel) {
        self.place = place
        self.viewModel = viewModel
    }
    
    var body: some View {
        VStack {
            ZStack {
                if let urlString = place.originalImage,
                   let url = URL(string: urlString) {
                    AsyncImage(url: url) { image in
                        image.image?.resizable()
                    }
                    .frame(maxWidth: .infinity, minHeight: 148, maxHeight: 148)
                    .background(Color(.white))
                    .clipped()
                } else {
                    Image(systemName: "photo")
                        .frame(maxWidth: .infinity, minHeight: 148)
                        .background(Color(hex: "#F6F5FA"))
                        .clipped()
                }
                Button {
                    viewModel.addPlace(contentId: place.contentId)
                    if tmpcheck == true {
                        self.tmpcheck = false
                    } else {
                        self.tmpcheck = true
                    }
                } label: {
                    let check = viewModel.saveList.contains { $0.contentTitle == place.contentTitle }
                    if !tmpcheck {
                        Image(uiImage: .bFbookmark1)
                            .foregroundColor(Color(.label))
                            .frame(width: 50, height: 50)
                            .scaledToFill()
                    } else {
                        Image(uiImage: .bFbookmark2)
                            .foregroundColor(Color(.label))
                            .frame(width: 50, height: 50)
                            .scaledToFill()
                    }
                }
                .position(x: UIScreen.main.bounds.width - 70, y: 30)
                .buttonStyle(PlainButtonStyle())
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
            }
            .padding(EdgeInsets(top: 0, leading: 15, bottom: 0, trailing: 15))
            
            HStack {
                Spacer()
                
                if place.publicTransport != "" ||
                    place.elevator != "" ||
                    place.restroom != "" ||
                    place.wheelchair != "" {
                    Image(uiImage: .wheelchair)
                        .scaledToFit()
                        .frame(width: 36, height: 36)
                    
                    Spacer()
                    
                    Image(uiImage: .senior)
                        .scaledToFit()
                        .frame(width: 36, height: 36)
                } else {
                    Image(uiImage: .wheelchair)
                        .frame(width: 36, height: 36)
                        .scaledToFit()
                        .opacity(0.2)
                    
                    Spacer()
                    
                    Image(uiImage: .senior)
                        .frame(width: 36, height: 36)
                        .scaledToFit()
                        .opacity(0.2)
                }
                
                Spacer()
                
                if place.stroller != "" ||
                    place.lactationRoom != "" ||
                    place.babySpareChair != "" {
                    Image(uiImage: .pregnant)
                        .frame(width: 36, height: 36)
                        .scaledToFit()
                } else {
                    Image(uiImage: .pregnant)
                        .frame(width: 36, height: 36)
                        .scaledToFit()
                        .opacity(0.2)
                }
                
                Spacer()
                
                if place.helpDog != "" ||
                    place.guideHuman != "" ||
                    place.braileBlock != "" {
                    Image(uiImage: .eyes)
                        .frame(width: 36, height: 36)
                        .scaledToFit()
                } else {
                    Image(uiImage: .eyes)
                        .frame(width: 36, height: 36)
                        .scaledToFit()
                        .opacity(0.2)
                }
                
                Spacer()
                
                if place.signGuide != "" ||
                    place.videoGuide != "" ||
                    place.hearingHandicapEtc != "" {
                    Image(uiImage: .ears)
                        .frame(width: 36, height: 36)
                        .scaledToFit()
                } else {
                    Image(uiImage: .ears)
                        .frame(width: 36, height: 36)
                        .scaledToFit()
                        .opacity(0.2)
                }
                
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
