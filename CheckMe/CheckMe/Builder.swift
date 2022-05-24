//
//  Builder.swift
//  CheckMe
//
//  Created by Vadim Sosnovsky on 23.05.22.
//  Copyright © 2022 Vadzim Sasnouski. All rights reserved.
//

import UIKit

protocol Builder {
    static func createWelcomModule() -> UIViewController
    static func createLoginModule() -> UIViewController
}

class ModelBuilder: Builder {
    static func createWelcomModule() -> UIViewController {
        let view = WelcomViewController()
        let presenter = WelcomPresenter(view: view)
        view.presenter = presenter
        return view
    }
    
    static func createLoginModule() -> UIViewController {
        let view = LoginViewController()
        let model = Login()
        let presenter = LoginPresenter(view: view, loginModel: model)
        view.presenter = presenter
        return view
    }
}
