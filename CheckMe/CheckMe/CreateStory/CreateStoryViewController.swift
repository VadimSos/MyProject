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

	var imagesArray: [UIImage] = []
	let ref = Database.database().reference()

	// MARK: - Lifecycle

	override func viewDidLoad() {
		super.viewDidLoad()
		descriptionTextView.text = "Description"
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
//		saveToCoreData(name: productNameTF.text!, description: descriptionTextView.text, label: categoryLabel.text!)

//		let displayMainVC = UIStoryboard(name: "MainTableViewController", bundle: nil).instantiateInitialViewController()
		saveInfoToFirebaseDB()
		tabBarController?.selectedIndex = 0
	}

	/*
	Firebase databases don't support adding images to the database.
	Need upload images to a storage provider such as Firebase Cloud Storage and then save the url to that file in database to download from later.
	*/
	func saveInfoToFirebaseDB() {

		guard let posts = Auth.auth().currentUser else {
			return
		}

		ref.child("posts").child(posts.uid).child("category").setValue(categoryLabel.text)
		ref.child("posts").child(posts.uid).child("description").setValue(descriptionTextView.text)
		ref.child("posts").child(posts.uid).child("productName").setValue(productNameTF.text, forKey: "like")

		/*
		//Create a reference to the image
		guard let user = Auth.auth().currentUser else { return }
		let imageRef = Storage.storage().reference().child("posts").child("images").child(user.uid)
		
		// Get image data
		let image = CreateStoryCollectionViewCell()
		if let uploadData = PhotoArray.shareInstance.photosArray.first?.pngData() {
		//CameraHandler.shared.imagePickedBlock?(image.photoImageView.image!.pngData()) {
		//image.photoImageView.image?.pngData() {
		//imagesArray.first?.pngData() {
		
		// Upload image to Firebase Cloud Storage
		imageRef.putData(uploadData, metadata: nil) { (metadata, error) in
		guard error == nil else {
		// Handle error
		return
		}
		// Get full image url
		imageRef.downloadURL { (url, error) in
		guard let downloadURL = url else {
		// Handle error
		return
		}
		
		// Save url to database
		Firestore.firestore().collection("images").document("myImage").setData(["imageUrl" : downloadURL.absoluteString])
		}
		}
		}
		*/
	}

	func didCellPressed(category: String) {
		categoryLabel.text = category
	}

//	func saveToCoreData(name: String, description: String, label: String) {
//		guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
//				return
//		}
//
//		let managedContext = appDelegate.persistentContainer.viewContext
//
//		let entity = NSEntityDescription.entity(forEntityName: "Post", in: managedContext)
//		let newUser = NSManagedObject(entity: entity!, insertInto: managedContext) as? Post
//
//		newUser?.name = name
//		newUser?.desciption = descriptionTextView.text
//		newUser?.category = categoryLabel.text
//		if let img = UIImage(named: "photo") {
//			let data = img.pngData() as NSData?
//			newUser?.photo = data
//		}
//		/*
//		setValue(productNameTF.text, forKey: "name")
//		newUser.setValue(descriptionTextView.text, forKey: "desciption")
//		newUser.setValue(categoryLabel.text, forKey: "category")
//		*/
//
//		do {
//			try managedContext.save()
//		} catch let error as NSError {
//			print("Could not save. \(error), \(error.userInfo)")
//		}
//	}
}

extension CreateStoryViewController: UITextViewDelegate {

	// MARK: - Description edditing

	func textViewDidBeginEditing(_ textView: UITextView) {
		if textView.textColor == UIColor.magnezium() {
			textView.text = nil
			textView.textColor = UIColor.black
		}
	}

	func textViewDidEndEditing(_ textView: UITextView) {
		if textView.text.isEmpty {
			textView.text = "Desription"
			textView.textColor = UIColor.magnezium()
		}
	}
}

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

extension CreateStoryViewController: UICollectionViewDelegate {

	func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		guard let cell = collectionView.cellForItem(at: indexPath) as? CreateStoryCollectionViewCell else {
			return
		}
		CameraHandler.shared.showActioSheet(vcAlert: self)
		CameraHandler.shared.imagePickedBlock = { (image) in
			cell.photoImageView.image = image
			self.imagesArray.append(image)
			print(image)
			print(self.imagesArray)
		}
	}
}
