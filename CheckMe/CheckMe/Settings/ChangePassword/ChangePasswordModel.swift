//
//  ChangePasswordModel.swift
//  CheckMe
//
//  Created by Vadim Sosnovsky on 17.06.22.
//  Copyright © 2022 Vadzim Sasnouski. All rights reserved.
//

import Foundation

enum ChangePasswordData {
    case initial(PasswordData?)
    case loading(PasswordData)
    case success(PasswordData)
    case failure(PasswordData)

    struct PasswordData {
        let password: String?
        let passwordConfirm: String?
    }
}
