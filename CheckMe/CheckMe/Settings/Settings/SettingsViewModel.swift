//
//  SettingsViewModel.swift
//  CheckMe
//
//  Created by Vadim Sosnovsky on 24.06.22.
//  Copyright © 2022 Vadzim Sasnouski. All rights reserved.
//

import Foundation
import FirebaseAuth
import FirebaseDatabase

protocol SettingsViewModelProtocol: class {
    var updateTable: ((SettingsUserData) -> Void)? { get set }
    func getUserData()
    init(firebase: FirebaseServiceProtocol)
}

class SettingsViewModel: SettingsViewModelProtocol {
    var updateTable: ((SettingsUserData) -> Void)?
    var firebase: FirebaseServiceProtocol?
    let ref = Database.database().reference()

    required init(firebase: FirebaseServiceProtocol) {
        self.firebase = firebase
    }

    func getUserData() {
        updateTable?(.loading)

        firebase?.getUserData(completion: { [weak self] result in
            switch result {
            case .success(let user):
                self?.updateTable?(.success(user))
            case .failure(let error):
                self?.updateTable?(.failure(error))
            }
        })
    }
}
