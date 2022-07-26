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
    var router: RouterProtocol!
    var routerTB: RouterTabBarProtocol!

    override func viewDidLoad() {
        super.viewDidLoad()

        setupChildVC()
        setTabBarAppearance()
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
                generateTabBarItems(viewController: viewController,
                                    title: "Home",
                                    image: UIImage(named: "Home_page"))
            case let viewController as CreateStoryViewController:
                builder?.createStoryModule(viewController: viewController, router: routerTB)
                generateTabBarItems(viewController: viewController,
                                    title: "Add story",
                                    image: UIImage(named: "Add_page"))
            case let viewController as FavoritesViewController:
                // TODO: - build favorities module
                generateTabBarItems(viewController: viewController,
                                    title: "Favorites",
                                    image: UIImage(named: "Like_page"))
            case let viewController as SettingsTableViewController:
                builder?.configureSettingsModule(viewController: viewController)
                generateTabBarItems(viewController: viewController,
                                    title: "Settings",
                                    image: UIImage(named: "Settings_page"))
            default:
                break
            }
        }
    }

    private func generateTabBarItems(viewController: UIViewController, title: String, image: UIImage?) {
        viewController.tabBarItem.title = title
        viewController.tabBarItem.image = image
    }

    private func setTabBarAppearance() {
        let xPosition: CGFloat = 10
        let yPosition: CGFloat = 10
        let width = tabBar.bounds.width - xPosition * 2
        let height = tabBar.bounds.height + yPosition * 2

        let roundLayer = CAShapeLayer()

        let bezierPath = UIBezierPath(roundedRect: CGRect(x: xPosition,
                                                          y: tabBar.bounds.minY - yPosition,
                                                          width: width,
                                                          height: height),
                                      cornerRadius: height / 2)

        roundLayer.path = bezierPath.cgPath

        tabBar.layer.insertSublayer(roundLayer, at: 0)

        tabBar.itemWidth = width / 5
        tabBar.itemPositioning = .centered

        roundLayer.fillColor = UIColor.black.cgColor
        tabBar.tintColor = .tabBatItemAccent
        tabBar.unselectedItemTintColor = .white
    }
}
