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
	@IBOutlet weak var nameTextField: UITextField!
	@IBOutlet weak var familyNameTextField: UITextField!
	@IBOutlet weak var cellPhoneNumberTF: UITextField!
	@IBOutlet weak var phoneNumberTF: UITextField!

	// MARK: Variables/Constants

	private let userMail = "MyMail"
	let userAccount = "MyAccount"
	let userPassword = "MyPassword"
	weak var delegate: CreateAccountViewControllerDElegate?

	// MARK: Lifecycle

	override func viewDidLoad() {
		super.viewDidLoad()

	}

	// MARK: Actions

	@IBAction func createAccountButtonDidTap(_ sender: UIButton) {
		if saveAccount() {
			delegateDataToLoginVC()
		}
	}

	@IBAction func cancelButtonDidTap(_ sender: UIButton) {
		dismiss(animated: true, completion: nil)
	}

	func delegateDataToLoginVC() {
		if let delegateMail = mailTextField.text {
			delegate?.swithToLoginVC(mail: delegateMail)
			dismiss(animated: true, completion: nil)
		}
	}

	func saveAccount() -> Bool {
		var result = false
		if let mail = mailTextField.text {
			if mail.textMailIsEmpty() {
				showAlertIfDataIsEmpty()
			} else {
				if mail.isValidLogin() {
					saveMail()
					result = true
				} else {
					showAlertIfDataIsIncorrect()
				}
			}
		}

		if let password = passowordTextField.text {
			if password.textPasswordIsEmpty(text: password) {
				showAlertIfDataIsEmpty()
				result = false
			} else {
				if password.isValidPassword(), passowordTextField.text == confirmpasswordTextField.text {
					savePassword()
					result = true
				} else {
					showAlertIfDataIsIncorrect()
					result = false
				}
			}
		}
		return result
	}

	func saveMail() {
			UserDefaults.standard.set(mailTextField.text, forKey: userMail)
	}

	func savePassword() {
		do {
			try Locksmith.updateData(data: [userAccount : passowordTextField.text!], forUserAccount: userPassword)
//			Locksmith.saveData(data: [userAccount : passowordTextField.text!], forUserAccount: userPassword)

		} catch {
			print("Password is not saved")
		}
	}

	// MARK: Alerts

	func showAlertIfDataIsIncorrect() {
		UIAlertController.showError(message: NSLocalizedString("Wrong data", comment: ""), from: self)
	}

	func showAlertIfDataIsEmpty() {
		UIAlertController.showError(message: NSLocalizedString("Empty data", comment: ""), from: self)
	}

	func showAlertDataSavedSuccefully() {
		UIAlertController.showSuccess(message: NSLocalizedString("Saved sucesfully", comment: ""), from: self)
	}
}
