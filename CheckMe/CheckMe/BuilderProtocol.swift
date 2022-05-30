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
        let presenter = LoginPresenter(view: view, loginModel: model)
        view.presenter = presenter
        return view
    }
}
