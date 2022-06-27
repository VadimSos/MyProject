//
//  TabBarController.swift
//  CheckMe
//
//  Created by Vadim Sosnovsky on 27.06.22.
//  Copyright © 2022 Vadzim Sasnouski. All rights reserved.
//

import UIKit

class TabBarController: UITabBarController {
    
    var builder: BuilderProtocol?

    override func viewDidLoad() {
        super.viewDidLoad()

        setupChildVC()
    }

    private func setupChildVC() {
        guard let viewControllers = viewControllers else { return }

        for viewController in viewControllers {
            var childVC: UIViewController?
            
            if let navigationController = viewController as? UINavigationController {
                childVC = navigationController.viewControllers.first
            } else {
                childVC = viewController
            }

            switch childVC {
            case let viewController as MainTableViewController:
                // TODO: - build main midule
                break
            case let viewController as CreateStoryViewController:
                // TODO: - build story module
                break
            case let viewController as FavoritesViewController:
                // TODO: - build favorities module
                break
            case let viewController as SettingsTableViewController:
                builder?.configureSettingsModule(viewController: viewController)
                viewController.tabBarItem.image = UIImage(named: "Settings_page")
            default:
                break
            }
        }
    }
}
