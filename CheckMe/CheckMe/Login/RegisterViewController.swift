//
//  CreateAccountViewController.swift
//  CheckMe
//
//  Created by Vadzim Sasnouski on 3/5/19.
//  Copyright © 2019 Vadzim Sasnouski. All rights reserved.
//

import UIKit
import Locksmith
import FirebaseAuth

protocol  RegisterViewControllerDElegate: class {
	func swithToLoginVC(mail: String)
}

class RegisterViewController: UIViewController {

	// MARK: Outlets

	@IBOutlet weak var mailTextField: UITextField!
	@IBOutlet weak var passowordTextField: UITextField!
	@IBOutlet weak var confirmpasswordTextField: UITextField!
	@IBOutlet weak var nameTextField: UITextField!
	@IBOutlet weak var familyNameTextField: UITextField!
	@IBOutlet weak var cellPhoneNumberTF: UITextField!
	@IBOutlet weak var phoneNumberTF: UITextField!

	// MARK: Variables/Constants

//	private let userMail = "MyMail"
//	let userAccount = "MyAccount"
//	let userPassword = "MyPassword"
	weak var delegate: RegisterViewControllerDElegate?

	// MARK: Lifecycle

	override func viewDidLoad() {
		super.viewDidLoad()

	}

	// MARK: Actions

	@IBAction func createAccountButtonDidTap(_ sender: UIButton) {
		guard saveAccount() else {
			return
		}
	}

	func delegateDataToLoginVC() {
		if let delegateMail = mailTextField.text {
			delegate?.swithToLoginVC(mail: delegateMail)
			dismiss(animated: true, completion: nil)
		}
	}

	func saveAccount() -> Bool {

		var result = false

		if let password = passowordTextField.text, let mail = mailTextField.text {
			if password.textPasswordIsEmpty(), mail.textMailIsEmpty() {
				showAlertIfDataIsEmpty()
				result = false
			} else {
				if password.isValidPassword(), passowordTextField.text == confirmpasswordTextField.text {
					createAccount()
					result = true
				} else {
					showAlertIfDataIsIncorrect()
					result = false
				}
			}
		}
		return result
	}

	func createAccount() {

		Auth.auth().createUser(withEmail: mailTextField.text!, password: passowordTextField.text!) { (authResult, error) in
			if error != nil {
				print(error!)
			} else {
				let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
				let loginVC = mainStoryboard.instantiateViewController(withIdentifier: "Main")
				if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
					appDelegate.window?.rootViewController = loginVC
				}
			}
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
