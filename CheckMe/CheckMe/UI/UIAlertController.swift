//
//  UIAlertController.swift
//  CheckMe
//
//  Created by Vadzim Sasnouski on 3/6/19.
//  Copyright © 2019 Vadzim Sasnouski. All rights reserved.
//

import UIKit

// MARK: Login Alert Controller

extension UIAlertController {
	static func showError(message: String, from viewController: UIViewController, with style: UIAlertAction.Style = .default) {

		let alertController = UIAlertController(title: NSLocalizedString("Error", comment: ""), message: message, preferredStyle: .alert)
		alertController.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: ""), style: style, handler: nil))

		viewController.present(alertController, animated: true, completion: nil)
	}

	static func showSuccess(message: String, from viewController: UIViewController) {

		showAlert(title: NSLocalizedString("Success", comment: ""),
				  message: message,
				  from: viewController)
	}

	static func showAlert(title: String, message: String, from viewController: UIViewController) {

		let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
		alertController.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: ""),
												style: .default,
												handler: nil))

		viewController.present(alertController, animated: true, completion: nil)
	}
}
