//
//  UIAlertController.swift
//  CheckMe
//
//  Created by Vadzim Sasnouski on 3/6/19.
//  Copyright © 2019 Vadzim Sasnouski. All rights reserved.
//

import UIKit

// MARK: Login Alert Controller

extension UIViewController {

	// MARK: - Alert with 'OK' button

	static func showAlert(title: String, message: String, from viewController: UIViewController) {

		let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
		alertController.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: ""),
												style: .default,
												handler: nil))

		viewController.present(alertController, animated: true, completion: nil)
	}

	static func showError(message: String, from viewController: UIViewController) {

		showAlert(title: NSLocalizedString("Error", comment: ""),
				  message: message,
				  from: viewController)
	}

	static func showSuccess(message: String, from viewController: UIViewController) {

		showAlert(title: NSLocalizedString("Success", comment: ""),
				  message: message,
				  from: viewController)
	}

	// MARK: - Alert with 'OK' and 'Cancel' buttons

	static func showAlertWithCancel(title: String, message: String, from viewController: UIViewController) {

		let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
		alertController.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: ""),
												style: .default,
												handler: nil))
		alertController.addAction(UIAlertAction(title: NSLocalizedString("Cancel", comment: ""),
												style: .cancel,
												handler: nil))

		viewController.present(alertController, animated: true, completion: nil)
	}

	static func showConfirm(message: String, from viewController: UIViewController) {

		showAlertWithCancel(title: NSLocalizedString("Confirm logout", comment: ""),
				  message: message,
				  from: viewController)
	}
}
