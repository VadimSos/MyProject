//
//  ChangePasswordViewModel.swift
//  CheckMe
//
//  Created by Vadim Sosnovsky on 17.06.22.
//  Copyright © 2022 Vadzim Sasnouski. All rights reserved.
//

import Foundation
import FirebaseAuth

protocol ChangePasswordViewModelProtocol {
    var updateViewData: ((ChangePasswordData) -> Void)? { get set }
    func resetPassword(with password: String)
    init(firebaseService: FirebaseServiceProtocol)
}

final class ChangePasswordViewModel: ChangePasswordViewModelProtocol {

    var updateViewData: ((ChangePasswordData) -> Void)?
    var firebaseService: FirebaseServiceProtocol?

    init(firebaseService: FirebaseServiceProtocol) {
        self.firebaseService = firebaseService

        updateViewData?(.initial(ChangePasswordData.PasswordData(password: "Initial",
                                                                 passwordConfirm: "Initial")))
    }

    func resetPassword(with password: String) {
        updateViewData?(.loading(ChangePasswordData.PasswordData(password: "Loading",
                                                                 passwordConfirm: "Loading")))
        firebaseService?.changePassword(password: password) { result in
            switch result {
            case .success(_):
                self.updateViewData?(.success(ChangePasswordData.PasswordData(password: "Success",
                                                                              passwordConfirm: "Succcess")))
            case .failure(_):
                self.updateViewData?(.failure(ChangePasswordData.PasswordData(password: "Failure",
                                                                              passwordConfirm: "Failure")))
            }
        }
    }
}
