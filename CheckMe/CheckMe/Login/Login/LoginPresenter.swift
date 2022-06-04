//
//  LoginPresenter.swift
//  CheckMe
//
//  Created by Vadim Sosnovsky on 24.05.22.
//  Copyright © 2022 Vadzim Sasnouski. All rights reserved.
//

import Foundation

protocol LoginViewProtocol: class {
    func resetPasswordWith(error: String?)
    func loginWith(error: String?)

    func setPasswordValidationWith(error: String?)
    func setMailValidationWith(error: String?)
}

protocol LoginPresenterProtocol: class {
    init(view: LoginViewProtocol,
         loginModel: Login,
         firebaseService: FirebaseServiceProtocol,
         router: RouterProtocol)
    func resetPasswordWith(mail: String?)
    func login(mail: String?, password: String?)
}

class LoginPresenter: LoginPresenterProtocol {
    weak var view: LoginViewProtocol?
    var loginModel: Login?
    var firebaseService: FirebaseServiceProtocol?
    var router: RouterProtocol?

    required init(view: LoginViewProtocol,
                  loginModel: Login,
                  firebaseService: FirebaseServiceProtocol,
                  router: RouterProtocol) {
        self.view = view
        self.loginModel = loginModel
        self.firebaseService = firebaseService
        self.router = router
    }

    func resetPasswordWith(mail: String?) {
        if validationMail(with: mail) == true {
            firebaseService?.passwordReset(mail: mail ?? "", completion: { [weak self] errorCode, error  in
                if error != nil {
                    self?.view?.resetPasswordWith(error: errorCode)
                } else {
                    self?.view?.resetPasswordWith(error: nil)
                }
            })
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

        firebaseService?.signIn(mail: mail, password: password, completion: { [weak self] errorCode, error in
            if error != nil {
                self?.view?.loginWith(error: errorCode)
            } else {
                self?.view?.loginWith(error: nil)
            }
        })
    }

    func validationMail(with mail: String?) -> Bool {
        var result = false
        if let mail = mail {
            if mail.textMailIsEmpty() {
                view?.setMailValidationWith(error: "Empty Mail")
                result = false
            } else {
                result = true
            }

            if mail.isValidLogin() {
                result = true
            } else {
                view?.setMailValidationWith(error: "Wrong Mail")
                result = false
            }
        }
        return result
    }

    func validationPassword(with password: String?) -> Bool {
        var result = false
        if let password = password {
            if password.textPasswordIsEmpty() {
                view?.setPasswordValidationWith(error: "Empty Password")
                result = false
            } else {
                result = true
            }

            if password.isValidPassword() {
                result = true
            } else {
                view?.resetPasswordWith(error: "Wrong Password")
                result = false
            }
        }
        return result
    }
}
