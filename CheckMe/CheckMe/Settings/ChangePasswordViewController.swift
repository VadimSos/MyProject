//
//  ChangePasswordViewController.swift
//  CheckMe
//
//  Created by Vadzim Sasnouski on 3/14/19.
//  Copyright © 2019 Vadzim Sasnouski. All rights reserved.
//

import UIKit
import Locksmith

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
			savePassword()
		}

		self.performSegue(withIdentifier: "returnToSettingsVC", sender: nil)
	}

	func savePassword() {
		do {
			try Locksmith.updateData(data: ["MyAccount": currentPasswordTextField.text!], forUserAccount: "MyPassword")
		} catch {
			print("Password is not saved")
		}
	}
}
