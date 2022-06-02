//
//  CreateAccountViewController.swift
//  CheckMe
//
//  Created by Vadzim Sasnouski on 3/5/19.
//  Copyright © 2019 Vadzim Sasnouski. All rights reserved.
//

import UIKit

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

    var presenter: RegisterPresenterProtocol!

	// MARK: Lifecycle

	override func viewDidLoad() {
		super.viewDidLoad()
		self.hideKeyboardWhenTappedAround()

	}

	// MARK: Actions

	@IBAction func createAccountButtonDidTap(_ sender: UIButton) {
        guard let mail = mailTextField.text, let password = passowordTextField.text else { return }
        presenter.create(mail: mail,
                         password: password,
                         name: nameTextField.text,
                         familyName: familyNameTextField.text,
                         phoneNumberFirst: Int(cellPhoneNumberTF.text ?? ""),
                         phoneNumberSecond: Int(phoneNumberTF.text ?? ""))
    }

    func switchToMainVC() {
        let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let loginVC = mainStoryboard.instantiateViewController(withIdentifier: "Main")
        UIApplication.shared.windows.first?.rootViewController = loginVC
        UIApplication.shared.windows.first?.makeKeyAndVisible()
    }
}

extension RegisterViewController: RegisterViewProtocol {
    func createUser(error: String?) {
        if let error = error {
            UIAlertController.showError(message: NSLocalizedString(error, comment: ""),
                                        from: self)
        } else {
            switchToMainVC()
        }
    }
}
