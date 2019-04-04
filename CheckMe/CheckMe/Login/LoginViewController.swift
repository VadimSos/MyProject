//
//  LoginViewController.swift
//  CheckMe
//
//  Created by Vadzim Sasnouski on 3/5/19.
//  Copyright © 2019 Vadzim Sasnouski. All rights reserved.
//

import UIKit
import Locksmith
import FirebaseAuth

class LoginViewController: UIViewController, RegisterViewControllerDElegate {

	// MARK: Outlets

	@IBOutlet weak var mailTextField: UITextField!
	@IBOutlet weak var passwordTextField: UITextField!

	// MAKR: Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
		self.hideKeyboardWhenTappedAround()
    }

//	override func viewWillAppear(_ animated: Bool) {
//		let login = UserDefaults.standard.string(forKey: "MyMail")
//		print(login ?? "Mail do not saved")
//		let password = Locksmith.loadDataForUserAccount(userAccount: "MyPassword")
//		print(password ?? "Password do not saved")
//	}
//
//	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//		if segue.identifier == "createAccount" {
//			guard let destinationVC = segue.destination as? RegisterViewController else {
//				return
//			}
//			destinationVC.delegate = self
//		}
//
//	}

	// MARK: Actions

	@IBAction func loginButtonDidTap(_ sender: UIButton) {
		if checkDataIsEmpty() {
			doLogin()
		}
	}

	@IBAction func forgotPasswordDidTap(_ sender: UIButton) {
		mailTextField.text = UserDefaults.standard.string(forKey: "MyMail")
		if let passoword = Locksmith.loadDataForUserAccount(userAccount: "MyPassword") {
			passwordTextField.text = (passoword["MyAccount"] as? String)
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
		Auth.auth().signIn(withEmail: mailTextField.text!, password: passwordTextField.text!) { (user, error) in
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
