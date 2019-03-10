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
	@IBOutlet weak var passwordTextField: UITextField!

	// MAKR: Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
    }

	override func viewWillAppear(_ animated: Bool) {
		let login = UserDefaults.standard.string(forKey: "MyMail")
		print(login ?? "Mail do not saved")
		let password = Locksmith.loadDataForUserAccount(userAccount: "MyPassword")
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

	@IBAction func loginButtonDidTap(_ sender: UIButton) {
		if checkDataIsEmpty() {
			doLogin()
		}
	}

	func swithToLoginVC(mail: String) {
		mailTextField.text = mail
	}

	func switchToMainVC() {
		let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
		let loginVC = mainStoryboard.instantiateViewController(withIdentifier: "Main")
		if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
			appDelegate.window?.rootViewController = loginVC
		}
	}

	func doLogin() {
		if mailTextField.text == UserDefaults.standard.string(forKey: "MyMail") {
			if let saveData = Locksmith.loadDataForUserAccount(userAccount: "MyPassword") {
				if passwordTextField.text == (saveData["MyAccount"] as? String) {
					switchToMainVC()
				} else {
					showAlertDataIsWrong()
				}
			} else {
				showAlertDataIsWrong()
			}
		} else {
			showAlertDataIsWrong()
		}
	}

	func checkDataIsEmpty() -> Bool {
		var result = false
		if let mail = mailTextField.text {
			if mail.textMailIsEmpty(text: mail) {
				showAlertDataIsEmpty()
			} else {
				result = true
			}
		}

		if let password = passwordTextField.text {
			if password.textPasswordIsEmpty(text: password) {
				showAlertDataIsWrong()
			} else {
				result = true
			}
		}
		return result
	}

	// MAKR: Alerts

	func showAlertDataIsEmpty() {
		UIAlertController.showError(message: NSLocalizedString("Data is emoty", comment: ""), from: self, with: .cancel)
	}

	func showAlertDataIsWrong() {
		UIAlertController.showError(message: NSLocalizedString("Data is wrong", comment: ""), from: self, with: .cancel)
	}

}
