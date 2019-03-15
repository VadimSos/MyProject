//
//  CreateStoryViewController.swift
//  CheckMe
//
//  Created by Vadzim Sasnouski on 3/7/19.
//  Copyright © 2019 Vadzim Sasnouski. All rights reserved.
//

import UIKit
import CoreData

class CreateStoryViewController: UIViewController, CategoryTableViewControllerDelegate {

	// MARK: - Variables

	@IBOutlet weak var categoryLabel: UILabel!
	@IBOutlet weak var descriptionTextView: UITextView!
	@IBOutlet weak var productNameTF: UITextField!

	// MARK: - Lifecycle

	override func viewDidLoad() {
		super.viewDidLoad()
		descriptionTextView.text = "Description"
		descriptionTextView.textColor = .magnezium()
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
		saveToCoreData(name: productNameTF.text!, description: descriptionTextView.text, label: categoryLabel.text!)

//		let displayMainVC = UIStoryboard(name: "MainTableViewController", bundle: nil).instantiateInitialViewController()
		tabBarController?.selectedIndex = 0
	}

	func didCellPressed(category: String) {
		categoryLabel.text = category
	}

	func saveToCoreData(name: String, description: String, label: String) {
		guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
				return
		}

		let managedContext = appDelegate.persistentContainer.viewContext

		let entity = NSEntityDescription.entity(forEntityName: "Post", in: managedContext)
		let newUser = NSManagedObject(entity: entity!, insertInto: managedContext)

		newUser.setValue(productNameTF.text, forKey: "name")
		newUser.setValue(descriptionTextView.text, forKey: "desciption")
		newUser.setValue(categoryLabel.text, forKey: "category")

		do {
			try managedContext.save()
		} catch let error as NSError {
			print("Could not save. \(error), \(error.userInfo)")
		}
	}
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
		CameraHandler.shared.showActioSheet(vc: self)
		CameraHandler.shared.imagePickedBlock = { (image) in
			cell.photoImageView.image = image
		}
	}
}
