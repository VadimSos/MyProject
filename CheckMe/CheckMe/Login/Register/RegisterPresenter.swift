//
//  RegisterPresenter.swift
//  CheckMe
//
//  Created by Vadim Sosnovsky on 31.05.22.
//  Copyright © 2022 Vadzim Sasnouski. All rights reserved.
//

import Foundation

protocol RegisterViewProtocol: class {
    func createUser(error: String?)
}

protocol RegisterPresenterProtocol: class {
    init(view: RegisterViewProtocol, model: RegisterModel, firebaseService: FirebaseService)
    func create(mail: String?, password: String?, name: String?, familyName: String?, phoneNumberFirst: Int?, phoneNumberSecond: Int?)
}

class RegisterPresenter: RegisterPresenterProtocol {
    weak var view: RegisterViewProtocol?
    var model: RegisterModel
    let firebaseService: FirebaseService

    required init(view: RegisterViewProtocol, model: RegisterModel, firebaseService: FirebaseService) {
        self.view = view
        self.model = model
        self.firebaseService = firebaseService
    }

    func create(mail: String?, password: String?, name: String?, familyName: String?, phoneNumberFirst: Int?, phoneNumberSecond: Int?) {
        model.mail = mail
        model.password = password
        model.name = name
        model.familyName = familyName
        model.phoneNumberFirst = phoneNumberFirst
        model.phoneNumberSecond = phoneNumberSecond

        firebaseService.create(user: model, completion: { errorCode, error in
            self.view?.createUser(error: errorCode)
        })
    }
}
