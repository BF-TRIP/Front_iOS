//
//  UserNameEnviroment.swift
//  BF_TRIP
//
//  Created by 박동재 on 3/22/25.
//

import SwiftUI

private struct UserNameKey: EnvironmentKey {
    static let defaultValue: String? = nil
}

extension EnvironmentValues {
    var userName: String? {
        get { self[UserNameKey.self] }
        set { self[UserNameKey.self] = newValue }
    }
}
