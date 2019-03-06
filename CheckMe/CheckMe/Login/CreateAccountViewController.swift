//
//  CreateAccountViewController.swift
//  CheckMe
//
//  Created by Vadzim Sasnouski on 3/5/19.
//  Copyright © 2019 Vadzim Sasnouski. All rights reserved.
//

import UIKit
import Locksmith

protocol  CreateAccountViewControllerDElegate: class {
	func swithToLoginVC(mail: String)
}

class CreateAccountViewController: UIViewController {

	// MARK: Outlets

	@IBOutlet weak var mailTextField: UITextField!
	@IBOutlet weak var passowordTextField: UITextField!
	@IBOutlet weak var confirmpasswordTextField: UITextField!

	// MARK: Variables/Constants

	let userMail = "MyMail"
	let userAccount = "MyAccount"
	let userPassword = "MyPassword"
	weak var delegate: CreateAccountViewControllerDElegate?

	// MARK: Lifecycle

	override func viewDidLoad() {
		super.viewDidLoad()

	}

	// MARK: Actions

	@IBAction func createAccountButtonDidTap(_ sender: UIButton) {
		saveAccount()
		delegateDataToLoginVC()
	}

	func delegateDataToLoginVC() {
		if let delegateMail = passowordTextField.text {
			delegate?.swithToLoginVC(mail: delegateMail)
			dismiss(animated: true, completion: nil)
		}
	}

	func saveAccount() {
		if textMailIsEmpty() {
			showAlertIfDataIsEmpty()
		} else {
			if let mailExist = mailTextField.text?.isValidLogin(), mailExist {
				saveMail()
			} else {
				showAlertIfDataIsIncorrect()
			}
		}

		if textPasswordIsEmpty() {
			showAlertIfDataIsEmpty()
		} else {
			if let dataExist = passowordTextField.text?.isValidPassword(), dataExist, passowordTextField.text == confirmpasswordTextField.text {
				savePassword()
			}
		}
	}

	func saveMail() {
		if let inputMail = mailTextField.text, inputMail.count > 0 {
			UserDefaults.standard.set(inputMail, forKey: "E-mail")
		}
	}

	func savePassword() {
		if let passData = Locksmith.loadDataForUserAccount(userAccount: userMail), passData[userPassword] != nil {
			do {
				try Locksmith.saveData(data: [userAccount : passowordTextField.text!], forUserAccount: userPassword)
			} catch {
				print("Password is not saved")
			}
		}
	}

	func textMailIsEmpty() -> Bool {
		var result = false
		if let login = mailTextField.text, login.count == 0 {
			result = true
		}
		return result
	}

	func textPasswordIsEmpty() -> Bool {
		var result = false
		if let password = passowordTextField.text, password.count == 0 {
			result = true
		}
		return result
	}

	// MARK: Alerts

	func showAlertIfDataIsIncorrect() {
		UIAlertController.showError(message: NSLocalizedString("Wrong data", comment: ""), from: self, with: .cancel)
	}

	func showAlertIfDataIsEmpty() {
		UIAlertController.showError(message: NSLocalizedString("Empty data", comment: ""), from: self, with: .cancel)
	}
}

// MARK: Validation login/password

extension String {
	func isValidLogin() -> Bool {
		let mailFormat = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
		return NSPredicate(format: "SELF MATCHES %@", mailFormat).evaluate(with: self)
	}

	func isValidPassword() -> Bool {
		//Minimum 8 characters at least 1 Uppercase Alphabet, 1 Lowercase Alphabet, 1 Number and 1 Special Character
		let passwordFormat = "^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)(?=.*[d$@$!%*?&#])[A-Za-z\\dd$@$!%*?&#]{8,}"
		let passwordPredicate = NSPredicate(format: "SELF MATCHES %@", passwordFormat).evaluate(with: self)
		return passwordPredicate
	}
}

extension UIAlertController {
	static func showError(message: String, from viewController: UIViewController, with style: UIAlertAction.Style = .default) {

		let alertController = UIAlertController(title: NSLocalizedString("Error", comment: ""), message: message, preferredStyle: .alert)
		alertController.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: ""), style: style, handler: nil))

		viewController.present(alertController, animated: true, completion: nil)
	}
}
