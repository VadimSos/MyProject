//
//  PostsModel.swift
//  CheckMe
//
//  Created by Vadzim Sasnouski on 4/1/19.
//  Copyright © 2019 Vadzim Sasnouski. All rights reserved.
//

import Foundation
import UIKit

class PostModel: PostModelProtocol {

	var pImage: UIImage
	var pName: String
	var pDescription: String
	var pCategory: String

	init(image: UIImage, name: String, description: String, category: String) {
		pImage = image
		pName = name
		pDescription = description
		pCategory = category
	}

	func postImage() -> UIImage {
		return self.pImage
	}

	func postName() -> String {
		return self.pName
	}

	func postDescription() -> String {
		return self.pDescription
	}

	func postCategory() -> String {
		return self.pCategory
	}
}
