//
//  Router.swift
//  CheckMe
//
//  Created by Vadim Sosnovsky on 30.05.22.
//  Copyright © 2022 Vadzim Sasnouski. All rights reserved.
//

import UIKit

protocol RouterMain {
    var navigationController: UINavigationController? { get set }
    var builder: BuilderProtocol? { get set }
}

protocol RouterProtocol: RouterMain {
    func initialViewController()
    func goToLoginVC()
    func goToRegisterVC()
    func popToRoot()
}

class Router: RouterProtocol {
    var navigationController: UINavigationController?
    var builder: BuilderProtocol?

    init(navigationController: UINavigationController, builder: BuilderProtocol) {
        self.navigationController = navigationController
        self.builder = builder
    }

    func initialViewController() {
        if let navigationController = navigationController {
            guard let welcomViewController = builder?.createWelcomModule(router: self) else { return }
            navigationController.pushViewController(welcomViewController, animated: true)
        }
    }

    func goToLoginVC() {
        if let navigationController = navigationController {
            guard let loginViewController = builder?.createLoginModule() else { return }
            navigationController.pushViewController(loginViewController, animated: true)
        }
    }
    
    func goToRegisterVC() {
        if let navigationController = navigationController {
            guard let loginViewController = builder?.createRegisterModule() else { return }
            navigationController.pushViewController(loginViewController, animated: true)
        }
    }

    func popToRoot() {
        if let navigationController = navigationController {
            navigationController.popToRootViewController(animated: true)
        }
    }
}
