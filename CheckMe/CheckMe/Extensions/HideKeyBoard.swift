//
//  HideKeyBoard.swift
//  CheckMe
//
//  Created by Vadzim Sasnouski on 3/15/19.
//  Copyright © 2019 Vadzim Sasnouski. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
	func hideKeyboardWhenTappedAround() {
		let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
		tap.cancelsTouchesInView = false
		view.addGestureRecognizer(tap)
	}

	@objc func dismissKeyboard() {
		view.endEditing(true)
	}
}
