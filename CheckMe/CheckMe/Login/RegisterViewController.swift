//
//  CreateAccountViewController.swift
//  CheckMe
//
//  Created by Vadzim Sasnouski on 3/5/19.
//  Copyright © 2019 Vadzim Sasnouski. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

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

	let ref = Database.database().reference()

	// MARK: Lifecycle

	override func viewDidLoad() {
		super.viewDidLoad()
		self.hideKeyboardWhenTappedAround()

	}

	override func viewWillDisappear(_ animated: Bool) {
		super.viewWillDisappear(animated)

		guard let userUID = Auth.auth().currentUser?.uid else { return }

		ref.child("users").child(userUID).child("name").setValue(nameTextField.text)
		ref.child("users").child(userUID).child("familyName").setValue(familyNameTextField.text)
		ref.child("users").child(userUID).child("cellPhoneNumber").setValue(cellPhoneNumberTF.text)
		ref.child("users").child(userUID).child("phoneNumber").setValue(phoneNumberTF.text)
	}

	// MARK: Actions

	@IBAction func createAccountButtonDidTap(_ sender: UIButton) {
		guard saveAccount() else {
			return
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
					showAlertDataSavedSuccefully()
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

		guard let mail = mailTextField.text, let password = passowordTextField.text else { return }

		Auth.auth().createUser(withEmail: mail, password: password) { (_, error) in
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
