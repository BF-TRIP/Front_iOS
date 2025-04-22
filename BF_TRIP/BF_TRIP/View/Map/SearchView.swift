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
                    .background(Color.White)
                    .cornerRadius(10)
                    .frame(height: 48)
                    .padding(.horizontal)
                    .padding(.top, 8)
                
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
        HStack(spacing: 8) {
            backButton
            searchField
        }
    }
    
    private var backButton: some View {
        Button { isSearchViewShowing = false
        } label: {
            Image(systemName: "chevron.backward")
                .font(.system(size: 14))
                .foregroundColor(Color.Black)
        }
        .padding(.leading, 12)
    }
    
    private var searchField: some View {
        TextField("   검색어를 입력해주세요.", text: $text)
            .autocorrectionDisabled()
            .padding(.vertical, 10)
            .background(Color.Gray100)
            .frame(maxWidth: .infinity)
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
                .font(.system(size: 14))
                .foregroundColor(Color.Black)
        }
    }

    private var clearButton: some View {
        Button(action: clearSearch) {
            Image(systemName: "multiply.circle.fill")
                .font(.system(size: 14))
                .foregroundColor(Color.Black)
                .padding()
        }
    }
    
    private var voiceButton: some View {
        Button(action: { isVoiceViewShowing.toggle() }) {
            Image(uiImage: .mic)
                .font(.system(size: 14))
                .foregroundColor(Color.Black)
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
