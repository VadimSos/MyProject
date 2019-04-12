//
//  LoginViewController.swift
//  CheckMe
//
//  Created by Vadzim Sasnouski on 3/5/19.
//  Copyright © 2019 Vadzim Sasnouski. All rights reserved.
//

import UIKit
import FirebaseAuth

class LoginViewController: UIViewController {

	// MARK: Outlets

	@IBOutlet weak var mailTextField: UITextField!
	@IBOutlet weak var passwordTextField: UITextField!

	// MAKR: Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
		self.hideKeyboardWhenTappedAround()
    }

	// MARK: Actions

	@IBAction func loginButtonDidTap(_ sender: UIButton) {
		if checkDataIsEmpty() {
			doLogin()
		}
	}

	@IBAction func forgotPasswordDidTap(_ sender: UIButton) {
		//TODO: Send a user a verification email, Send a password reset email
	}

	func switchToMainVC() {
		let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
		let loginVC = mainStoryboard.instantiateViewController(withIdentifier: "Main")
		if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
			appDelegate.window?.rootViewController = loginVC
		}
	}

	func doLogin() {
		guard let mail = mailTextField.text, let password = passwordTextField.text else { return }
		Auth.auth().signIn(withEmail: mail, password: password) { (_, error) in
			if error != nil {
				print(error!)
			} else {
				self.switchToMainVC()
			}
		}
	}

	func checkDataIsEmpty() -> Bool {
		var result = false
		if let mail = mailTextField.text {
			if mail.textMailIsEmpty() {
				showAlertDataIsEmpty()
			} else {
				result = true
			}

			if mail.isValidLogin() {
				result = true
			} else {
				showAlertDataIsWrong()
				result = false
			}
		}

		if let password = passwordTextField.text {
			if password.textPasswordIsEmpty() {
				showAlertDataIsEmpty()
			} else {
				result = true
			}

			if password.isValidPassword() {
				result = true
			} else {
				showAlertDataIsWrong()
				result = false
			}
		}
		return result
	}

	// MAKR: Alerts

	func showAlertDataIsEmpty() {
		UIAlertController.showError(message: NSLocalizedString("Data is empty",
															   comment: ""), from: self)
	}

	func showAlertDataIsWrong() {
		UIAlertController.showError(message: NSLocalizedString("Data is wrong", comment: ""), from: self)
	}

}
