//
//  ProtocolForPostModel.swift
//  CheckMe
//
//  Created by Vadzim Sasnouski on 4/8/19.
//  Copyright © 2019 Vadzim Sasnouski. All rights reserved.
//

import Foundation
import UIKit

protocol PostModelProtocol {
	func postImage() -> UIImage
	func postName() -> String
	func postDescription() -> String
	func postCategory() -> String
	func postLike() -> Bool
}
