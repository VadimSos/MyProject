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
	}

	// MARK: - Actions

	@IBAction func stopBarButton(_ sender: UIBarButtonItem) {
	}
	@IBAction func changePasswordButtonDidTap(_ sender: UIButton) {

		if let saveData = Locksmith.loadDataForUserAccount(userAccount: "MyAccount") {
			if currentPasswordTextField.text == (saveData["MyAccount"] as? String) && currentPasswordTextField.text == newPasswordTextField.text {
				savePassword()
			}
		}

		self.performSegue(withIdentifier: "returnToSettingsVC", sender: nil)
	}

	func savePassword() {
		do {
			try Locksmith.updateData(data: ["MyAccount" : currentPasswordTextField.text!], forUserAccount: "MyPassword")
		} catch {
			print("Password is not saved")
		}
	}

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
