//
//  CameraHandler.swift
//  CheckMe
//
//  Created by Vadzim Sasnouski on 3/12/19.
//  Copyright © 2019 Vadzim Sasnouski. All rights reserved.
//

import Foundation
import UIKit

class CameraHandler: NSObject {

	static let shared = CameraHandler()

	fileprivate var currentVC: UIViewController!

	// MARK: - Internal Properties
	var imagePickedBlock: ((UIImage) -> Void)?

	func camera() {
		if UIImagePickerController.isSourceTypeAvailable(.camera) {
			let myPickerController = UIImagePickerController()
			myPickerController.delegate = self
			myPickerController.sourceType = .camera
			currentVC.present(myPickerController, animated: true, completion: nil)
		}
	}

	func photoLibrary() {
		if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
			let myPickerController = UIImagePickerController()
			myPickerController.delegate = self
			myPickerController.sourceType = .photoLibrary
			currentVC.present(myPickerController, animated: true, completion: nil)
		}
	}

	func showActioSheet(vcAlert: UIViewController) {
		currentVC = vcAlert
		let actionSheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)

		actionSheet.addAction(UIAlertAction(title: NSLocalizedString("Camera", comment: ""), style: .default, handler: { (_: UIAlertAction) -> Void in
			self.camera()
		}))

		actionSheet.addAction(UIAlertAction(title: NSLocalizedString("Gallery", comment: ""), style: .default, handler: { (_: UIAlertAction!) -> Void in
			self.photoLibrary()
		}))

		actionSheet.addAction(UIAlertAction(title: NSLocalizedString("Cancel", comment: ""), style: .cancel, handler: nil))

		vcAlert.present(actionSheet, animated: true, completion: nil)
	}
}

extension CameraHandler: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
	func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
		currentVC.dismiss(animated: true, completion: nil)
	}

	func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
		if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
//			let collectionImage = CreateStoryCollectionViewCell()
			self.imagePickedBlock?(image)
//			PhotoArray.shareInstance.photosArray.append(image)
//			collectionImage.photoImageView.image = image
		} else {
			print("Something went wrong")
		}
		currentVC.dismiss(animated: true, completion: nil)
	}
}
