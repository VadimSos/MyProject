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

	@IBOutlet weak var newPasswordTextField: UITextField!
	@IBOutlet weak var confirmNewPasswordTextField: UITextField!

    var changePasswordViewModel: ChangePasswordViewModelProtocol!
    var viewData: ChangePasswordData = .initial(nil)
    var testValue = 0

	// MARK: - Lifecycle

	override func viewDidLoad() {
		super.viewDidLoad()
		self.hideKeyboardWhenTappedAround()

        changePasswordViewModel.updateViewData = { data in
            self.viewData = data
            switch data {
            case .initial(let initial):
                self.update(viewData: initial)
            case .loading(let loading):
                self.update(viewData: loading)
            case .success(let success):
                self.update(viewData: success)
            case .failure(let failure):
                self.update(viewData: failure)
            }
        }
	}

	@IBAction func changePasswordButtonDidTap(_ sender: UIButton) {
        changePasswordViewModel.resetPassword(with: newPasswordTextField.text ?? "")
        }

        private func update(viewData: ChangePasswordData.PasswordData?) {
            newPasswordTextField.text = viewData?.password
            confirmNewPasswordTextField.text = viewData?.passwordConfirm
        }
}
