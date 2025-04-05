//
//  PlaceViewModel.swift
//  BF_TRIP
//
//  Created by 박동재 on 10/10/24.
//

import Foundation
import SwiftUI

final class PlaceViewModel: ObservableObject {
    
    @Published var saveList: [ResponsePlaceDTO] = []
    
    @MainActor
    func requestList(userNumber: Int) async {
        do {
            saveList = try await MoyaManager.shared.getSavePlaceList(userNumber: userNumber)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func addPlace(userNumber: Int, contentId: Int) async {
        do {
            let _ = try await MoyaManager.shared.AddSaveList(userNumber: userNumber, contentId: contentId)
            await requestList(userNumber: userNumber)
        } catch {
            print(error.localizedDescription)
            await requestList(userNumber: userNumber)
        }
    }
    
    func deletePlace(userNumber: Int, contentId: Int) async {
        do {
            let _ = try await MoyaManager.shared.deletePlace(userNumber: userNumber, contentId: contentId)
            await requestList(userNumber: userNumber)
        } catch {
            print(error.localizedDescription)
            await requestList(userNumber: userNumber)
        }
    }
    
}
