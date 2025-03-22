//
//  DataManager.swift
//  BF_TRIP
//
//  Created by 박동재 on 2/22/25.
//

import Foundation

final class DataManager {
    
    static let shared = DataManager()
    private let userIdKey = "userId"
    private let userNameKey = "userName"
    
    func saveUserId(_ userId: Int) {
        UserDefaults.standard.set(userId, forKey: userIdKey)
    }
    
    func saveUserName(_ userName: String) {
        UserDefaults.standard.set(userName, forKey: userNameKey)
    }
    
    func loadUserId() -> Int? {
        return UserDefaults.standard.object(forKey: userIdKey) as? Int
    }
    
    func loadUserName() -> String? {
        return UserDefaults.standard.object(forKey: userNameKey) as? String
    }
    
}
