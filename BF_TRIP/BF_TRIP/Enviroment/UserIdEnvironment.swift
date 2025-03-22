//
//  UserIdEnvironment.swift
//  BF_TRIP
//
//  Created by 박동재 on 2/22/25.
//

import SwiftUI

private struct UserIdKey: EnvironmentKey {
    static let defaultValue: Int? = nil
}

extension EnvironmentValues {
    var userId: Int? {
        get { self[UserIdKey.self] }
        set { self[UserIdKey.self] = newValue }
    }
}
