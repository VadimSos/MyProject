//
//  ChangePasswordViewController.swift
//  CheckMe
//
//  Created by Vadzim Sasnouski on 3/14/19.
//  Copyright © 2019 Vadzim Sasnouski. All rights reserved.
//

import UIKit
import FirebaseAuth

class ChangePasswordViewController: UIViewController {

	// MARK: - Variables

	@IBOutlet weak var newPasswordTextField: UITextField!
	@IBOutlet weak var confirmNewPasswordTextField: UITextField!
	
	// MARK: - Lifecycle

	override func viewDidLoad() {
		super.viewDidLoad()
		self.hideKeyboardWhenTappedAround()
	}

	// MARK: - Actions

	@IBAction func returnToSettingsVC(_ sender: UIBarButtonItem) {
		self.performSegue(withIdentifier: "stopBarButton", sender: nil)
			}

	@IBAction func changePasswordButtonDidTap(_ sender: UIButton) {

		changePassword()
	}

	func changePassword() {
		if let password = confirmNewPasswordTextField.text,
			newPasswordTextField.text == confirmNewPasswordTextField.text {
			Auth.auth().currentUser?.updatePassword(to: password, completion: { (error) in
				if let error = error {
					if let errorCode = AuthErrorCode(rawValue: error._code) {
						UIAlertController.showError(message: NSLocalizedString(errorCode.errorMessages, comment: ""),
													from: self)
					}
				} else {
					self.performSegue(withIdentifier: "returnToSettingsVC", sender: nil)
				}
			})
		}
	}
}
