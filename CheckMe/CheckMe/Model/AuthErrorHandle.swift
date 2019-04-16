//
//  AuthErrorHandle.swift
//  CheckMe
//
//  Created by Vadzim Sasnouski on 4/16/19.
//  Copyright © 2019 Vadzim Sasnouski. All rights reserved.
//

import Foundation
import UIKit
import FirebaseAuth

extension AuthErrorCode {
	var errorMessages: String {
		switch self {
		case .emailAlreadyInUse:
			return "Mail already used"
		case .userNotFound:
			return "User not found"
		case .networkError:
			return "Network request failed"
		default:
			return "Error happened"
		}
	}
}
