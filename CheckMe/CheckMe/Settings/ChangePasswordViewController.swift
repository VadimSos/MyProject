//
//  ChangePasswordViewController.swift
//  CheckMe
//
//  Created by Vadzim Sasnouski on 3/14/19.
//  Copyright © 2019 Vadzim Sasnouski. All rights reserved.
//

import UIKit

class ChangePasswordViewController: UIViewController {

	// MARK: - Variables

	@IBOutlet weak var currentPasswordTextField: UITextField!
	@IBOutlet weak var newPasswordTextField: UITextField!

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

		if currentPasswordTextField.text == newPasswordTextField.text {
			changePassword()
		}

		self.performSegue(withIdentifier: "returnToSettingsVC", sender: nil)
	}

	func changePassword() {
		//TODO: change password in firebase
	}
}
