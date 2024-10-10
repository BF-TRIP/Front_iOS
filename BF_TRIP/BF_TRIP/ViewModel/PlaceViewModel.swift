//
//  PlaceViewModel.swift
//  BF_TRIP
//
//  Created by 박동재 on 10/10/24.
//

import Foundation

final class PlaceViewModel: ObservableObject {
    
    private let userNumber = 42
    @Published var saveList: [ResponseSaveDTO] = []
    
    func requestList() {
        MoyaManager.shared.IdToList(userNumber: self.userNumber) { result in
            switch result {
            case .success(let data):
                dump(data)
                self.saveList = data
            case .failure(let error):
                dump(error.localizedDescription)
            }
        }
    }
    
    func addPlace(contentId: Int) {
        MoyaManager.shared.AddSaveList(userNumber: self.userNumber, contentId: contentId) { result in
            switch result {
            case .success(let data):
                dump(data)
            case .failure(let error):
                dump(error.localizedDescription)
            }
        }

    }
    
}
