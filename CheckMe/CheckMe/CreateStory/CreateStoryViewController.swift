//
//  CreateStoryViewController.swift
//  CheckMe
//
//  Created by Vadzim Sasnouski on 3/7/19.
//  Copyright © 2019 Vadzim Sasnouski. All rights reserved.
//

import UIKit

class CreateStoryViewController: UIViewController, CategoryTableViewControllerDelegate {

	// MARK: - Variables

	@IBOutlet weak var categoryLabel: UILabel!
	@IBOutlet weak var descriptionTextView: UITextView!
//	var magnesiumColor = UIColor.init(red: 0.754, green: 0.754, blue: 0.754, alpha: 1.0)

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

	func didCellPressed(category: String) {
		categoryLabel.text = category
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
