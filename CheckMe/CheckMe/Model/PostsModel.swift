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
	var pLike: Bool

	init(image: UIImage, name: String, description: String, category: String, like: Bool) {
		pImage = image
		pName = name
		pDescription = description
		pCategory = category
		pLike = like
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
	
	func postLike() -> Bool {
		return self.pLike
	}
}
