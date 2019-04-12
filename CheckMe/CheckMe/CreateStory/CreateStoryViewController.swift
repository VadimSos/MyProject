//
//  CreateStoryViewController.swift
//  CheckMe
//
//  Created by Vadzim Sasnouski on 3/7/19.
//  Copyright © 2019 Vadzim Sasnouski. All rights reserved.
//

import UIKit
import CoreData
import Firebase

class CreateStoryViewController: UIViewController, CategoryTableViewControllerDelegate {

	// MARK: - Variables

	@IBOutlet weak var categoryLabel: UILabel!
	@IBOutlet weak var descriptionTextView: UITextView!
	@IBOutlet weak var productNameTF: UITextField!

	let refDB = Database.database().reference()
	let refStorage = Storage.storage().reference()

	// MARK: - Lifecycle

	override func viewDidLoad() {
		super.viewDidLoad()
		descriptionTextView.text = NSLocalizedString("Description", comment: "")
		descriptionTextView.textColor = .magnezium()

		self.hideKeyboardWhenTappedAround()
	}

	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if segue.identifier == "showCategoryVC" {
			guard let destinationVC = segue.destination as? CategoryTableViewController else {
				return
			}
			destinationVC.delegate = self
		}
	}

	// MARK: - Actions

	@IBAction func choseCategoryButtonDidTap(_ sender: UIButton) {
	}

	@IBAction func savePostButtonDidTap(_ sender: UIButton) {
		saveInfoToFirebaseDB()
		tabBarController?.selectedIndex = 0
	}

	func saveInfoToFirebaseDB() {

		guard let posts = Auth.auth().currentUser else {
			return
		}

		let postUserRef = refDB.child("posts").child(posts.uid)

		postUserRef.child("category").setValue(categoryLabel.text)
		postUserRef.child("description").setValue(descriptionTextView.text)
		postUserRef.child("productName").setValue(productNameTF.text)
		postUserRef.child("like").setValue(false)

		//Create a reference to the image
		let imageRef = refStorage.child("posts").child("images").child(posts.uid)

		// Get image data
		if let uploadData = PhotoArray.sharedInstance.photosArray.first?.pngData() {

			// Upload image to Firebase Cloud Storage
			imageRef.putData(uploadData, metadata: nil) { (_, error) in
				guard error == nil else {
					// Handle error
					return
				}

				// Get full image url
				imageRef.downloadURL { (url, _) in
					guard let downloadURL = url else {
						// Handle error
						return
					}

					// Save url to database
					postUserRef.child("photoURL").setValue(["imageUrl": downloadURL.absoluteString])
				}
			}
		}
	}

	func didCellPressed(category: String) {
		categoryLabel.text = category
	}
}

	// MARK: - UITextViewDelegate

extension CreateStoryViewController: UITextViewDelegate {

	//Description edditing
	func textViewDidBeginEditing(_ textView: UITextView) {
		if textView.textColor == .magnezium() {
			textView.text = nil
			textView.textColor = .black
		}
	}

	func textViewDidEndEditing(_ textView: UITextView) {
		if textView.text.isEmpty {
			textView.text = "Desription"
			textView.textColor = .magnezium()
		}
	}
}

	// MARK: - UICollectionViewDataSource

extension CreateStoryViewController: UICollectionViewDataSource {
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return 8
	}

	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "photoCell", for: indexPath) as? CreateStoryCollectionViewCell else {
			fatalError()
		}

		cell.photoImageView.image = UIImage(named: "AddPhotoToCollection")
		return cell
	}
}

	// MARK: - UICollectionViewDelegate

extension CreateStoryViewController: UICollectionViewDelegate {

	func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		guard let cell = collectionView.cellForItem(at: indexPath) as? CreateStoryCollectionViewCell else {
			return
		}
		CameraHandler.shared.showActioSheet(vcAlert: self)
		CameraHandler.shared.imagePickedBlock = { (image) in
			cell.photoImageView.image = image
			PhotoArray.sharedInstance.photosArray.append(image)
		}
	}
}
