//
//  LoginViewController.swift
//  CheckMe
//
//  Created by Vadzim Sasnouski on 3/5/19.
//  Copyright © 2019 Vadzim Sasnouski. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

	// MARK: Outlets

	@IBOutlet weak var mailTextField: UITextField!
	@IBOutlet weak var passwordTextField: UITextField!

    var presenter: LoginPresenterProtocol!

	// MAKR: Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
		self.hideKeyboardWhenTappedAround()
    }

	// MARK: Actions

	@IBAction func loginButtonDidTap(_ sender: UIButton) {
        presenter.login(mail: mailTextField.text, password: passwordTextField.text)
	}

	@IBAction func forgotPasswordDidTap(_ sender: UIButton) {

		guard let mail = mailTextField.text else { return }
        presenter.resetPasswordWith(mail: mail)
	}

	func switchToMainVC() {
		let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
		let loginVC = mainStoryboard.instantiateViewController(withIdentifier: "Main")
		if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
			appDelegate.window?.rootViewController = loginVC
		}
	}

	// MAKR: Alerts

	func showAlertDataIsEmpty() {
		UIAlertController.showError(message: NSLocalizedString("Data is empty", comment: ""),
									from: self)
	}

	func showAlertDataIsWrong() {
		UIAlertController.showError(message: NSLocalizedString("Data is wrong", comment: ""),
									from: self)
	}

}

extension LoginViewController: LoginViewProtocol {
    func resetPasswordWith(error: String?) {
        if let error = error {
            UIAlertController.showError(message: NSLocalizedString(error, comment: ""),
                                        from: self)
        }
    }

    func loginWith(error: String?) {
        if let error = error {
            UIAlertController.showError(message: NSLocalizedString(error, comment: ""),
                                        from: self)
        } else {
            switchToMainVC()
        }
    }

    func setPasswordValidationWith(error: String?) {
        if error == "Empty" {
            showAlertDataIsEmpty()
        } else {
            showAlertDataIsWrong()
        }
    }

    func setMailValidationWith(error: String?) {
        if error == "Empty" {
            showAlertDataIsEmpty()
        } else {
            showAlertDataIsWrong()
        }
    }
}
