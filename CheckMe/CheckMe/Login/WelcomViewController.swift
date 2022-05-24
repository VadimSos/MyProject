//
//  WelcomViewController.swift
//  CheckMe
//
//  Created by Vadzim Sasnouski on 3/27/19.
//  Copyright © 2019 Vadzim Sasnouski. All rights reserved.
//

import UIKit
import Reachability

class WelcomViewController: UIViewController {

    var presenter: WelcomPresenterProtocol!

    override func viewDidLoad() {
        super.viewDidLoad()

    }

	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)

        self.presenter.showReachability()
	}
    @IBAction func loginButtonDidTap(_ sender: RoundButtons) {
        let loginViewController = ModelBuilder.createLoginModule()
        navigationController?.pushViewController(loginViewController, animated: true)
    }

    func alert(message: String) {
        let alert = UIAlertController(title: "Netowrk status", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}

extension WelcomViewController: WelcomViewProtocol {
    func getReachabilityConnected(status: Bool) {
        if status == true {
            self.alert(message: "Connected")
        } else {
            self.alert(message: "Network is not available")
        }
    }
}
