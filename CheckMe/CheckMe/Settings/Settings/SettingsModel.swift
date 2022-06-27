//
//  SettingsModel.swift
//  CheckMe
//
//  Created by Vadim Sosnovsky on 24.06.22.
//  Copyright © 2022 Vadzim Sasnouski. All rights reserved.
//

import Foundation

enum SettingsUserData {
    case initial
    case loading
    case success(UserData)
    case failure(Error)

    struct UserData {
        let name: String?
        let familyName: String?
        let phoneNumber: String?
        let additionalPhoneNumber: String?
    }
}
