//
//  StringExtension.swift
//  CheckMe
//
//  Created by Vadzim Sasnouski on 3/6/19.
//  Copyright © 2019 Vadzim Sasnouski. All rights reserved.
//

import Foundation

// MAKR: Text Characters Match Validation

extension String {

	func isValidLogin() -> Bool {
		let mailFormat = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
		return NSPredicate(format: "SELF MATCHES %@", mailFormat).evaluate(with: self)
	}

	func isValidPassword() -> Bool {
		//Minimum 8 characters at least 1 Uppercase Alphabet, 1 Lowercase Alphabet, 1 Number and 1 Special Character
		let passwordFormat = "^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)(?=.*[d$@$!%*?&#])[A-Za-z\\dd$@$!%*?&#]{8,}"
		let passwordPredicate = NSPredicate(format: "SELF MATCHES %@", passwordFormat).evaluate(with: self)
		return passwordPredicate
	}

	// MAKR:- Text Empty Validation

	func isEmpty() -> Bool {
		return self.count == 0
	}

	func textMailIsEmpty() -> Bool {
		return isEmpty()
	}

	func textPasswordIsEmpty(text: String?) -> Bool {
		var result = false
		if let password = text, password.count == 0 {
			result = true
		}
		return result
	}
}
