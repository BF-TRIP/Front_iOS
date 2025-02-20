//
//  OnboardingViewModel.swift
//  BF_TRIP
//
//  Created by 박동재 on 2/18/25.
//

import Foundation

final class OnboardingViewModel: ObservableObject {
    
    @Published private(set) var name: String = ""
    @Published private(set) var birth: Date = Date()
    @Published private(set) var gender: Int? = nil
    @Published private(set) var disabilityList: [Bool] = Array(repeating: false, count: 4)
    @Published private(set) var tripList: [Bool] = Array(repeating: false, count: 4)
    
    private var selectedDisabilities: [Int] {
        disabilityList.enumerated()
            .filter { $0.element }
            .map { $0.offset + 1 }
    }
    
    private var selectedTripTypes: [Int] {
        tripList.enumerated()
            .filter { $0.element }
            .map { $0.offset + 1 }
    }
    
    private var selectedGender: String {
        gender == 0 ? "man" : "woman"
    }
    
    func postJoin() {
        MoyaManager.shared.postJoin(
            name: name,
            gender: selectedGender,
            birth: birth.toDateString(),
            disability: selectedDisabilities,
            tripType: selectedTripTypes) { result in
                switch result {
                case .success(let success):
                    print(success)
                case .failure(let error):
                    dump(error.localizedDescription)
                }
            }
    }
    
    func updateName(_ newValue: String) {
        if newValue.count > 5 {
            name = String(newValue.prefix(5))
        } else {
            name = newValue
        }
    }
    
    func updateBirth(_ newBirth: Date) {
        birth = newBirth
    }
    
    func updateGender(_ newGender: Int?) {
        gender = newGender
    }
    
    func toggleDisability(at index: Int) {
        guard index >= 0 && index < disabilityList.count else { return }
        disabilityList[index].toggle()
    }
    
    func toggleTrip(at index: Int) {
        guard index >= 0 && index < tripList.count else { return }
        tripList[index].toggle()
    }
    
}
