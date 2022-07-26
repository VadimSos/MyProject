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
    func goToPreviousVC()
    func popToRoot()
}

protocol RouterTabBarProtocol {
    var tabBarController: UITabBarController? { get set }
    var builder: BuilderProtocol? { get set }
    var navigationController: [UINavigationController?] { get set }

    func goToCategoryVC()
    func returnToCreateStoryVC(with category: String)
    func goToPreviousVC(with index: Int)
    func popToRoot(with index: Int)
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
//        if let navigationController = navigationController {
            let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let mainViewController = mainStoryboard.instantiateViewController(withIdentifier: "Main")
            if let tabBarController = mainViewController as? TabBarController {
                tabBarController.builder = builder
                tabBarController.router = self
                tabBarController.routerTB = RouterTabBar(tabBarController: tabBarController, builder: builder!)

                UIApplication.shared.windows.first?.rootViewController = mainViewController
                UIApplication.shared.windows.first?.makeKeyAndVisible()
            }
//            navigationController.pushViewController(mainViewController, animated: true)
//        }
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

class RouterTabBar: RouterTabBarProtocol {
    var navigationController: [UINavigationController?]
    var builder: BuilderProtocol?
    var tabBarController: UITabBarController?

    enum TabBarIndex: Int {
        case mainVC = 0
        case favoriteVC
        case createStoryVC
        case settingsVC
    }

    init(tabBarController: TabBarController, builder: BuilderProtocol) {
        self.builder = builder
        self.tabBarController = tabBarController

        let mainNavigation = tabBarController.viewControllers?[TabBarIndex.mainVC.rawValue] as? UINavigationController
        let favoriteNavigation = tabBarController.viewControllers?[TabBarIndex.favoriteVC.rawValue] as? UINavigationController
        let createStoryNavigation = tabBarController.viewControllers?[TabBarIndex.createStoryVC.rawValue] as? UINavigationController
        let settingsNavigation = tabBarController.viewControllers?[TabBarIndex.settingsVC.rawValue] as? UINavigationController

        self.navigationController = [mainNavigation, favoriteNavigation, createStoryNavigation, settingsNavigation]
    }

    func goToCategoryVC() {
        if navigationController.count == 4 {
            guard let categoryViewController = builder?.createCategoryTableModule(router: self) else { return }
            navigationController[TabBarIndex.createStoryVC.rawValue]?.pushViewController(categoryViewController, animated: true)
        }
    }

    func returnToCreateStoryVC(with category: String) {
        let thirdTabBatControllerIndex = TabBarIndex.createStoryVC.rawValue
        if let navVC = tabBarController?.viewControllers?[thirdTabBatControllerIndex] as? UINavigationController {
            if let createStoryVC = navVC.viewControllers.first as? CreateStoryViewController {
                createStoryVC.setupStoryView(with: category)
                goToPreviousVC(with: thirdTabBatControllerIndex)
            }
        }
    }

    func goToPreviousVC(with index: TabBarIndex.RawValue) {
        if let navigationController = tabBarController?.viewControllers?[index] as? UINavigationController {
            navigationController.popViewController(animated: true)
        }
    }

    func popToRoot(with index: TabBarIndex.RawValue) {
        if let navigationController = tabBarController?.viewControllers?[index] as? UINavigationController {
            navigationController.popToRootViewController(animated: true)
        }
    }
}
