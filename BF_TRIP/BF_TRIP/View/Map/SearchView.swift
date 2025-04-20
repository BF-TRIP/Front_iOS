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
    @State var isVoiceViewShowing: Bool = false
    
    @Binding var text: String
    @State var editText: Bool = false
    
    @State var viewModel: MapViewModel = MapViewModel()
    
    var body: some View {
        NavigationStack {
            VStack {
                searchBar
                
                Spacer()
                
                Text("관광지를 검색해보세요!")
                    .font(.headline)
                
                Spacer()
            }
        }
        .fullScreenCover(isPresented: $isPlaceListViewShowing) {
            PlaceListView(
                title: "\"\(text)\" 검색 결과",
                searching: true,
                isPlaceListViewShowing: $isPlaceListViewShowing,
                viewModel: viewModel
            )
        }
        .fullScreenCover(isPresented: $isVoiceViewShowing) {
            VoiceView(isVoiceViewShowing: $isVoiceViewShowing)
        }
        .transaction { $0.disablesAnimations = true }
    }
    
    private var searchBar: some View {
        HStack {
            backButton
            searchField
        }
        .padding(EdgeInsets(top: 5, leading: 15, bottom: 5, trailing: 15))
    }
    
    private var backButton: some View {
        Button(action: { isSearchViewShowing = false }) {
            Image(systemName: "chevron.backward")
                .font(.system(size: 18))
                .foregroundColor(.primary)
                .padding(5)
        }
    }
    
    private var searchField: some View {
        TextField("검색어를 입력해주세요.", text: $text)
            .autocorrectionDisabled()
            .padding(15)
            .background(Color(.systemGray6))
            .cornerRadius(15)
            .overlay(searchOverlay)
            .onSubmit {
                if(text != "") {
                    viewModel.requestText(text: self.text)
                    self.isPlaceListViewShowing = true
                }
            }
            .submitLabel(.search)
    }
    
    private var searchOverlay: some View {
        HStack {
            Spacer()

            if !text.isEmpty {
                searchButton
                clearButton
            } else {
                voiceButton
            }
        }
    }
    
    private var searchButton: some View {
        Button(action: performSearch) {
            Image(systemName: "magnifyingglass")
                .foregroundColor(.primary)
        }
    }

    private var clearButton: some View {
        Button(action: clearSearch) {
            Image(systemName: "multiply.circle.fill")
                .foregroundColor(.primary)
                .padding()
        }
    }
    
    private var voiceButton: some View {
        Button(action: { isVoiceViewShowing.toggle() }) {
            Image(systemName: "mic")
                .foregroundColor(.primary)
                .padding()
        }
    }

    private func performSearch() {
        viewModel.requestText(text: text)
        isPlaceListViewShowing = true
    }

    private func clearSearch() {
        text = ""
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
    
}
