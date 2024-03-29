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
    func createLoginModule(router: RouterProtocol) -> UIViewController
    func createRegisterModule(router: RouterProtocol) -> UIViewController
    func configureSettingsModule(viewController: SettingsTableViewController)
    func createStoryModule(viewController: CreateStoryViewController, router: RouterTabBarProtocol)
    func createCategoryTableModule(router: RouterTabBarProtocol) -> UIViewController
}

class ModuleBuilder: BuilderProtocol {
    func createWelcomModule(router: RouterProtocol) -> UIViewController {
        let view = WelcomViewController()
        let presenter = WelcomPresenter(view: view, router: router)
        view.presenter = presenter
        return view
    }

    func createLoginModule(router: RouterProtocol) -> UIViewController {
        let view = LoginViewController()
        let model = Login()
        let firebaseService = FirebaseService()
        let presenter = LoginPresenter(view: view,
                                       loginModel: model,
                                       firebaseService: firebaseService,
                                       router: router)
        view.presenter = presenter
        return view
    }

    func createRegisterModule(router: RouterProtocol) -> UIViewController {
        let view = RegisterViewController()
        let model = RegisterModel()
        let firebaseService = FirebaseService()
        let presenter = RegisterPresenter(view: view,
                                          model: model,
                                          firebaseService: firebaseService,
                                          router: router)
        view.presenter = presenter
        return view
    }

    func configureSettingsModule(viewController: SettingsTableViewController) {
        let firebase = FirebaseService()
        let viewModel = SettingsViewModel(firebase: firebase)
        viewController.viewModel = viewModel
    }

    func createStoryModule(viewController: CreateStoryViewController, router: RouterTabBarProtocol) {
        let firebaseService = FirebaseService()
        let presenter = CreateStoryPresenter(view: viewController,
                                             firebaseService: firebaseService,
                                             router: router,
                                             model: CategoryModel.category)
        viewController.presenter = presenter
    }

    func createCategoryTableModule(router: RouterTabBarProtocol) -> UIViewController {
        let mainStoryboard = UIStoryboard(name: "CreateStory", bundle: nil)
        let view = mainStoryboard.instantiateViewController(withIdentifier: "createStory") as? CategoryTableViewController
//        let view = CategoryTableViewController()
        let presenter = CategoryPresenter(view: view!,
                                          model: CategoryModel.category,
                                          router: router)
        view!.presenter = presenter
        return view!
    }
}
