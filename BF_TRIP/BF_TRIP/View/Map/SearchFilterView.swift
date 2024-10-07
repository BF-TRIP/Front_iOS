//
//  SearchFilterView.swift
//  BF-TRIP
//
//  Created by 박동재 on 9/28/24.
//

import SwiftUI

struct SearchFilterView: View {
    
    @Binding var isFilterViewShowing: Bool
    @State var isPlaceListViewShowing: Bool = false
    
    @State var showPlaceListView: Bool = false
    
    @State private var selectedState: String = ""
    @State private var selectedStateIndex: Int? = nil
    @State private var selectedCity: String = ""
    
    @StateObject var viewModel: MapViewModel = MapViewModel()
    
    private let stateList: [String] = ["서울", "경기", "인천", "강원", "충북", "충남", "경북", "경남", "전북", "전남", "제주"]
    
    //TODO: 광역시에 대한 것도 할건 지
    private let cityList: [[String]] = [
        ["전체", "종로구", "중구", "용산구", "성동구", "광진구", "동대문구", "중랑구", "성북구", "강북구", "도봉구", "노원구", "은평구", 
         "서대문구", "마포구", "양천구", "강서구", "구로구", "금천구", "영등포구", "동작구", "관악구", "서초구", "강남구", "송파구", "강동구"],
        ["전체", "고양시", "파주시", "김포시", "의정부시", "양주시", "포천시", "동두천시", "남양주시", "구리시", "광주시", "하남시", "이천시", "여주시", "수원시", 
         "성남시", "용인시", "안성시", "과천시", "안양시", "의왕시", "군포시", "화성시", "평택시", "부천시", "광명시", "시흥시", "안산시", "오산시"],
        ["전체", "중구", "동구", "미추홀구", "연수구", "남동구", "부평구", "계양구", "서구", "강화군", "웅진군"],
        ["전체", "원주시", "춘천시", "강릉시", "동해시", "속초시", "홍천군", "삼척시", "횡성군", "철원군", 
         "평창군", "태백시", "영월군", "정선군", "인제군", "양양군", "고성군", "화천군", "양구군"],
        ["전체", "청주시", "충주시", "제천시", "보은군", "증평군", "옥천군", "영동군", "괴산군", "진천군", "음성군", "단양군"],
        ["전체", "천안시", "아산시", "서산시", "당진시", "공주시", "보령시", "논산시", "계룡시",
         "흥성군", "예산군", "부여군", "서천군", "청양군", "태안군", "금산군"],
        ["전체", "포항시", "경주시", "안동시", "김천시", "구미시", "영주시", "영천시", "상주시", "문경시", "경산시", "의정군",
         "청송군", "영양군", "영덕군", "청도군", "고령군", "성주군", "칠곡군", "예천군", "봉화군", "울진군", "울릉군"],
        ["전체", "창원시", "진주시", "김해시", "양산시", "거제시", "통영시", "사천시", "밀양시", "의령군",
         "함안군", "창녕군", "고성군", "남해군", "하동군", "산청군", "함양군", "거창군", "합천군"],
        ["전체", "전주시", "군산시", "익산시", "정읍시", "남원시", "김제시", "완주군", "진안군", "무주군", "장수군", "임실군", "순창군", "고창군", "부안군"],
        ["전체", "목포시", "여수시", "순천시", "나주시", "광양시", "담양군", "곡성군", "구례군", "고흥군", "보성군", "화순군", "장흥군", "강진군", "해남군", "영암군", "무안군", "함평군", "영광군", "장성군", "완도군", "진도군", "신안군"],
        ["전체", "제주시", "서귀포시"]
    ]
    
    var body: some View {
        
        VStack {
            HStack {
                Button {
                    self.isFilterViewShowing = false
                } label: {
                    Image(systemName: "chevron.backward")
                        .foregroundColor(Color(.label))
                }
                .padding()
                
                Spacer()
            }
            
            Spacer()
            
            Text("원하는 여행지의")
                .font(.system(size: 20))
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(EdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 0))
            Text("위치를 검색해주세요")
                .font(.system(size: 20))
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(EdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 0))
            
            Spacer()
            
            HStack {
                List(0..<self.stateList.count, id: \.self) { index in
                    Text("\(stateList[index])")
                        .frame(maxWidth: .infinity, alignment: .center)
                        .font(.system(size: 16))
                        .foregroundColor(self.selectedState == stateList[index] ? Color(.label) : Color(hex: "#949494"))
                        .listRowBackground(self.selectedState == stateList[index] ? Color(hex: "#FFE023") : Color(hex: "#E2E2E2"))
                        .listRowSeparator(.hidden)
                        .onTapGesture {
                            self.selectedState = stateList[index]
                            self.selectedStateIndex = index
                        }
                }
                .listStyle(PlainListStyle())
                .frame(width: 120, height: CGFloat(self.stateList.count) * 50)
                .scrollDisabled(true)
                if let stateIndex = selectedStateIndex {
                    List(0..<cityList[stateIndex].count, id: \.self) { index in
                        Text("\(cityList[stateIndex][index])")
                            .listRowBackground(self.selectedCity == cityList[stateIndex][index] ? Color(hex: "#FFFCE7") : Color(.white))
                            .onTapGesture {
                                self.selectedCity = cityList[stateIndex][index]
                            }
                    }
                    .listStyle(PlainListStyle())
                    .frame(width: 240, height: CGFloat(self.stateList.count) * 50)
                    .scrollBounceBehavior(.basedOnSize)
                } else {
                    List {
                        EmptyView()
                    }
                    .listStyle(PlainListStyle())
                    .frame(width: 240, height: CGFloat(self.stateList.count) * 50)
                    .scrollBounceBehavior(.basedOnSize)
                }
            }
            .frame(height: CGFloat(self.stateList.count) * 50)
            
            Spacer()
            
            HStack {
                Button {
                    //TODO: API 통신 후 받은 데이터 결과 화면 이동
                    viewModel.requestState(state: self.selectedState, city: self.selectedCity)
                    self.isPlaceListViewShowing = true
                    self.showPlaceListView = true
                } label: {
                    Text("적용하기")
                        .frame(maxWidth: .infinity, maxHeight: 53)
                        .foregroundColor(Color(.label))
                        .fontWeight(.bold)
                }
                .buttonStyle(.plain)
                .background(Color(hex: "#FFE023"))
                .cornerRadius(10)
                .padding(EdgeInsets(top: 10, leading: 30, bottom: 10, trailing: 30))
            }
        }
        .fullScreenCover(isPresented: $isPlaceListViewShowing, content: {
            PlaceListView(
                title: "\"\(selectedState) \(selectedCity)\" 검색 결과",
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
