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
    func goToMainVC()
    func goToCategoryVC()
    func returnToCreateStoryVC(with category: String)
    func goToPreviousVC()
    func popToRoot()
}

class Router: RouterProtocol {
    var navigationController: UINavigationController?
    var builder: BuilderProtocol?
    var selfTabBarController: TabBarController?

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
            guard let loginViewController = builder?.createLoginModule(router: self) else { return }
            navigationController.pushViewController(loginViewController, animated: true)
        }
    }

    func goToRegisterVC() {
        if let navigationController = navigationController {
            guard let loginViewController = builder?.createRegisterModule(router: self) else { return }
            navigationController.pushViewController(loginViewController, animated: true)
        }
    }

    func goToMainVC() {
        if let navigationController = navigationController {
            let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let mainViewController = mainStoryboard.instantiateViewController(withIdentifier: "Main")
            if let tabBarController = mainViewController as? TabBarController {
                selfTabBarController = tabBarController
                tabBarController.builder = builder
                tabBarController.router = self
            }
            UIApplication.shared.windows.first?.rootViewController = navigationController
            UIApplication.shared.windows.first?.makeKeyAndVisible()
            navigationController.pushViewController(mainViewController, animated: true)
        }
    }

    func goToCategoryVC() {
        if let navigationController = navigationController {
            guard let categoryViewController = builder?.createCategoryTableModule(router: self) else { return }
            navigationController.pushViewController(categoryViewController, animated: true)
        }
    }

    func returnToCreateStoryVC(with category: String) {
        let thirdTabBatController = (selfTabBarController?.viewControllers?.count ?? 4) - 2
        if let navVC = selfTabBarController?.viewControllers?[thirdTabBatController] as? UINavigationController {
            if let createStoryVC = navVC.viewControllers.first as? CreateStoryViewController {
                createStoryVC.setupStoryView(with: category)
                goToPreviousVC()
            }
        }
    }

    func goToPreviousVC() {
        if let navigationController = navigationController {
            navigationController.popViewController(animated: true)
        }
    }

    func popToRoot() {
        if let navigationController = navigationController {
            navigationController.popToRootViewController(animated: true)
        }
    }
}
