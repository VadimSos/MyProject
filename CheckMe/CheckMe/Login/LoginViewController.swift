//
//  LoginViewController.swift
//  CheckMe
//
//  Created by Vadzim Sasnouski on 3/5/19.
//  Copyright © 2019 Vadzim Sasnouski. All rights reserved.
//

import UIKit
import Locksmith

class LoginViewController: UIViewController, CreateAccountViewControllerDElegate {

	// MARK: Outlets

	@IBOutlet weak var mailTextField: UITextField!

	// MAKR: Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
    }

	override func viewWillAppear(_ animated: Bool) {
		let login = UserDefaults.standard.string(forKey: "MyMail")
		print(login ?? "Mail do not saved")
		let password = Locksmith.loadDataForUserAccount(userAccount: "MyAccount")
		print(password ?? "Password do not saved")
	}

	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if segue.identifier == "createAccount" {
			guard let destinationVC = segue.destination as? CreateAccountViewController else {
				return
			}
			destinationVC.delegate = self
		}

	}

	// MARK: Actions

	func swithToLoginVC(mail: String) {
		mailTextField.text = mail
	}

}
