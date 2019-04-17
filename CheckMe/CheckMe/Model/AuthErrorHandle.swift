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
			return NSLocalizedString("Mail already used", comment: "")
		case .userNotFound:
			return NSLocalizedString("User not found", comment: "")
		case .networkError:
			return NSLocalizedString("Network request failed", comment: "")
		case .missingEmail:
			return NSLocalizedString("E-mail missing", comment: "")
		default:
			return NSLocalizedString("Error happened", comment: "")
		}
	}
}
