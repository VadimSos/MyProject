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

		//TODO: changePassword function call
		self.performSegue(withIdentifier: "returnToSettingsVC", sender: nil)
	}

//	func changePassword() {
//		guard let newPassword = newPasswordTextField.text else { return	}
//		Auth.auth().currentUser?.updatePassword(to: newPassword, completion: { (error) in
//			if let error = error {
//				print(error)
//				//TODO: proceed the error
//			} else {
//				print("Success")
//			}
//		})
//	}

	func changePassword(email: String, currentPassword: String, newPassword: String, completion: @escaping (Error?) -> Void) {
		let credential = EmailAuthProvider.credential(withEmail: email, password: currentPassword)
		Auth.auth().currentUser?.reauthenticate(with: credential, completion: { (error) in
			if error == nil {
				Auth.auth().currentUser?.updatePassword(to: newPassword) { (errror) in
					completion(errror)
				}
			} else {
				completion(error)
			}
		})
	}
}
