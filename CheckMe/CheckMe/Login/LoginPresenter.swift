//
//  LoginPresenter.swift
//  CheckMe
//
//  Created by Vadim Sosnovsky on 24.05.22.
//  Copyright © 2022 Vadzim Sasnouski. All rights reserved.
//

import Foundation
import FirebaseAuth

protocol LoginViewProtocol: class {
    func resetPasswordWith(error: String?)
    func loginWith(error: String?)

    func setPasswordValidationWith(error: String?)
    func setMailValidationWith(error: String?)
}

protocol LoginPresenterProtocol: class {
    init(view: LoginViewProtocol, loginModel: Login)
    func resetPasswordWith(mail: String?)
    func login(mail: String?, password: String?)
}

class LoginPresenter: LoginPresenterProtocol {
    weak var view: LoginViewProtocol?
    var loginModel: Login?

    required init(view: LoginViewProtocol, loginModel: Login) {
        self.view = view
        self.loginModel = loginModel
    }

    func resetPasswordWith(mail: String?) {

        if validationMail(with: mail) == true {
            Auth.auth().sendPasswordReset(withEmail: mail!) { (error) in
                if let error = error {
                    if let errorCode = AuthErrorCode(rawValue: error._code) {
                        self.view?.resetPasswordWith(error: errorCode.errorMessages)
                    }
                } else {
                    self.view?.resetPasswordWith(error: nil)
                }
            }
        }

    }

    func login(mail: String?, password: String?) {
        if validationMail(with: mail) == true && validationPassword(with: password) == true {

            loginModel?.mail = mail
            loginModel?.password = password

            doLogin(mail: mail, password: password)
        }
    }

    func doLogin(mail: String?, password: String?) {

        guard let mail = mail, let password = password else { return }

        Auth.auth().signIn(withEmail: mail, password: password) { (_, error) in
            if let error = error {
                if let errorCode = AuthErrorCode(rawValue: error._code) {
                    self.view?.loginWith(error: errorCode.errorMessages)
                    }
                } else {
                    self.view?.loginWith(error: nil)
            }
        }
    }

    func validationMail(with mail: String?) -> Bool {
        var result = false
        if let mail = mail {
            if mail.textMailIsEmpty() {
                view?.setMailValidationWith(error: "Empty")
                result = false
            } else {
                result = true
            }

            if mail.isValidLogin() {
                result = true
            } else {
                view?.setMailValidationWith(error: "Wrong")
                result = false
            }
        }
        return result
    }

    func validationPassword(with password: String?) -> Bool {
        var result = false
        if let password = password {
            if password.textPasswordIsEmpty() {
                view?.setPasswordValidationWith(error: "Empty")
                result = false
            } else {
                result = true
            }

            if password.isValidPassword() {
                result = true
            } else {
                view?.resetPasswordWith(error: "Wrong")
                result = false
            }
        }
        return result
    }
}
