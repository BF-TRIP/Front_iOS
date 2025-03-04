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
                    .frame(maxWidth: .infinity, minHeight: 160, maxHeight: 160)
                    .background(Color(.white))
                    .cornerRadius(15)
                } else {
                    Image(uiImage: .placeholder)
                        .resizable()
                        .frame(maxWidth: .infinity, minHeight: 160, maxHeight: 160)
                        .background(Color(hex: "#F6F5FA"))
                        .cornerRadius(15)
                }
                Button {
                    viewModel.addPlace(contentId: place.contentId)
                    if tmpcheck == true {
                        self.tmpcheck = false
                    } else {
                        self.tmpcheck = true
                    }
                } label: {
                    let check = viewModel.saveList.contains { $0.courseName == place.contentTitle }
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
                    .font(.system(size: 18, weight: .bold))
                    .foregroundColor(.black)
                
                Spacer()
            }
            
            HStack {
                Text("\(place.addr)")
                    .font(.system(size: 12, weight: .semibold))
                    .foregroundColor(.black)
                
                Spacer()
            }
            
            HStack {
                if place.publicTransport != "" ||
                    place.elevator != "" ||
                    place.restroom != "" ||
                    place.wheelchair != "" {
                    Image(uiImage: .wheelchair)
                        .scaledToFit()
                        .frame(height: 32)
                    
                    Spacer()
                    
                    Image(uiImage: .senior)
                        .scaledToFit()
                        .frame(height: 32)
                } else {
                    Image(uiImage: .wheelchair)
                        .frame(height: 32)
                        .scaledToFit()
                        .opacity(0.2)
                    
                    Spacer()
                    
                    Image(uiImage: .senior)
                        .frame(height: 32)
                        .scaledToFit()
                        .opacity(0.2)
                }
                
                Spacer()
                
                if place.stroller != "" ||
                    place.lactationRoom != "" ||
                    place.babySpareChair != "" {
                    Image(uiImage: .pregnant)
                        .frame(width: 32, height: 32)
                        .scaledToFit()
                } else {
                    Image(uiImage: .pregnant)
                        .frame(width: 32, height: 32)
                        .scaledToFit()
                        .opacity(0.2)
                }
                
                Spacer()
                
                if place.helpDog != "" ||
                    place.guideHuman != "" ||
                    place.braileBlock != "" {
                    Image(uiImage: .eyes)
                        .frame(height: 32)
                        .scaledToFit()
                } else {
                    Image(uiImage: .eyes)
                        .frame(height: 32)
                        .scaledToFit()
                        .opacity(0.2)
                }
                
                Spacer()
                
                if place.signGuide != "" ||
                    place.videoGuide != "" ||
                    place.hearingHandicapEtc != "" {
                    Image(uiImage: .ears)
                        .frame(height: 32)
                        .scaledToFit()
                } else {
                    Image(uiImage: .ears)
                        .frame(height: 32)
                        .scaledToFit()
                        .opacity(0.2)
                }
            }
            .frame(maxWidth: .infinity, maxHeight: 48)
            .background(Color(.white))
            .padding(EdgeInsets(top: 0, leading: 5, bottom: 15, trailing: 5))
            
        }
        .background(.white)
        .cornerRadius(20)
    }
}
