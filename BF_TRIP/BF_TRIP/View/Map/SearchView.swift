//
//  SearchView.swift
//  BF_TRIP
//
//  Created by 박동재 on 10/3/24.
//

import SwiftUI

struct SearchView: View {
    
    @Binding var isSearchViewShowing: Bool
    @State var isPlaceListViewShowing: Bool = false
    
    @Binding var text: String
    @State var editText: Bool = false
    
    @State var viewModel: MapViewModel = MapViewModel()
    
    var body: some View {
        NavigationStack {
            HStack {
                Button {
                    isSearchViewShowing = false;
                } label: {
                    Image(systemName: "chevron.backward")
                        .foregroundColor(Color(.label))
                }
                
                Spacer()
                
                TextField("검색어를 입력해주세요.", text: self.$text)
                    .autocorrectionDisabled()
                    .padding(15)
                    .padding(.horizontal, 15)
                    .background(Color(.systemGray6))
                    .cornerRadius(15)
                    .overlay(
                        HStack {
                            Spacer()
                            
                            if self.editText {
                                Button {
                                    viewModel.requestText(text: self.text)
                                    self.isPlaceListViewShowing = true
                                } label: {
                                    Image(systemName: "magnifyingglass")
                                        .foregroundColor(Color(.label))
                                }
                                Button {
                                    self.editText = false
                                    self.text = ""
                                    UIApplication.shared.sendAction(
                                        #selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil
                                    )
                                } label: {
                                    Image(systemName: "multiply.circle.fill")
                                        .foregroundColor(Color(.label))
                                        .padding()
                                }
                            } else {
                                Button {
                                    //TODO: 음성녹음 띄우기
                                } label: {
                                    Image(systemName: "mic")
                                        .foregroundColor(Color(.label))
                                        .padding()
                                }
                            }
                        }
                    )
                    .onTapGesture {
                        self.editText = true
                    }
            }
            .padding(EdgeInsets(top: 5, leading: 15, bottom: 5, trailing: 15))
            
            Spacer()
            
            Text("관광지를 검색해보세요!")
            
            Spacer()
        }
        .fullScreenCover(isPresented: $isPlaceListViewShowing, content: {
            PlaceListView(
                title: "\"\(self.text)\" 검색 결과",
                searching: true,
                isPlaceListViewShowing: $isPlaceListViewShowing,
                viewModel: self.viewModel
            )
        })
        .transaction { transaction in
            transaction.disablesAnimations = true
        }
    }
    
}
