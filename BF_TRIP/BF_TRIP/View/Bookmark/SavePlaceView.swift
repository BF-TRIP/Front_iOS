//
//  SavePlaceView.swift
//  BF_TRIP
//
//  Created by 박동재 on 3/9/25.
//

import SwiftUI

struct SavePlaceView: View {
    
    @Binding var userNumber: Int
    @Binding var places: [ResponsePlaceDTO]
    @Binding var place: ResponsePlaceDTO
    
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
                    Task {
                        await deletePlace(userNumber: userNumber, contentId: place.contentId)
                    }
                } label: {
                    Image(uiImage: .bFbookmark2)
                        .foregroundColor(Color(.label))
                        .frame(width: 50, height: 50)
                        .scaledToFill()
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
            accessibilityIconsSection(place: $place)
        }
    }
    
    private func deletePlace(userNumber: Int, contentId: Int) async {
        do {
            let _ = try await MoyaManager.shared.deletePlace(userNumber: userNumber, contentId: contentId)
            
            // 로컬에서 해당 관광지를 즉시 제거
            if let index = places.firstIndex(where: { $0.contentId == contentId }) {
                places.remove(at: index)
            }
        } catch {
            print(error.localizedDescription)
            if let index = places.firstIndex(where: { $0.contentId == contentId }) {
                places.remove(at: index)
            }
        }
    }
    
}
