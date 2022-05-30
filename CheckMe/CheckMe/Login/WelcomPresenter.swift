//
//  LoginWelcomPresenter.swift
//  CheckMe
//
//  Created by Vadim Sosnovsky on 23.05.22.
//  Copyright © 2022 Vadzim Sasnouski. All rights reserved.
//

import Foundation
import Reachability

protocol WelcomViewProtocol: class {
    func getReachabilityConnected(status: Bool)
}

protocol WelcomPresenterProtocol: class {
    init(view: WelcomViewProtocol, router: RouterProtocol)
    func checkReachability()
    func tapOnLogin()
}

class WelcomPresenter: WelcomPresenterProtocol {
    weak var view: WelcomViewProtocol?
    var router: RouterProtocol?
    var reachability: Reachability?

    required init(view: WelcomViewProtocol, router: RouterProtocol) {
        self.view = view
        self.router = router
    }

    func checkReachability() {
        reachability = Reachability()

        if reachability?.connection != Reachability.Connection.none {
            self.view?.getReachabilityConnected(status: true)
        } else {
            view?.getReachabilityConnected(status: false)
        }
    }

    func tapOnLogin() {
        router?.goToLoginVC()
    }
}
