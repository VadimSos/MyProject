//
//  Builder.swift
//  CheckMe
//
//  Created by Vadim Sosnovsky on 23.05.22.
//  Copyright © 2022 Vadzim Sasnouski. All rights reserved.
//

import UIKit

protocol BuilderProtocol {
    func createWelcomModule(router: RouterProtocol) -> UIViewController
    func createLoginModule() -> UIViewController
    func createRegisterModule() -> UIViewController
}

class ModuleBuilder: BuilderProtocol {
    func createWelcomModule(router: RouterProtocol) -> UIViewController {
        let view = WelcomViewController()
        let presenter = WelcomPresenter(view: view, router: router)
        view.presenter = presenter
        return view
    }

    func createLoginModule() -> UIViewController {
        let view = LoginViewController()
        let model = Login()
        let firebaseService = FirebaseService()
        let presenter = LoginPresenter(view: view, loginModel: model, firebaseService: firebaseService)
        view.presenter = presenter
        return view
    }
    
    func createRegisterModule() -> UIViewController {
        let view = RegisterViewController()
        let model = RegisterModel()
        let firebaseService = FirebaseService()
        let presenter = RegisterPresenter(view: view, model: model, firebaseService: firebaseService)
        view.presenter = presenter
        return view
    }
}
