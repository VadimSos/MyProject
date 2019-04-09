//
//  FavoritesViewController.swift
//  CheckMe
//
//  Created by Vadzim Sasnouski on 3/7/19.
//  Copyright © 2019 Vadzim Sasnouski. All rights reserved.
//

import UIKit
import CoreData
import Firebase

class FavoritesViewController: UIViewController {

	// MARK: - Variables

	@IBOutlet weak var favoritesTV: UITableView!
//	var postNameFavoritesCD: [Post] = []
	var postsArray: [PostModel] = []
	var imageArray: [UIImage] = []
	let refDB = Database.database().reference()
	let storage = Storage.storage().reference()

	// MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
    }

	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)

	}

	// MARK: - Actions

	func displayPostsFavoritesVC() {

		guard let posts = Auth.auth().currentUser else {
			return
		}

		//download images
		let storageRef = storage.child("posts").child("images").child(posts.uid)

		storageRef.getData(maxSize: 100 * 1024 * 1024) { (data, error) in
			if let error = error {
				print(error)
			} else {
				let image = UIImage(data: data!)
				self.imageArray.append(image!)

				//download posts
				self.refDB.child("posts").child(posts.uid).observeSingleEvent(of: .value) { (snapshot) in

					let value = snapshot.value as? [String: Any]
					let postCategory = value?["category"] as? String ?? ""
					let postDescription = value?["description"] as? String ?? ""
					let postProductName = value?["productName"] as? String ?? ""
					let postLike = value?["like"] as? Bool ?? false

					let post = PostModel(image: self.imageArray.first ?? UIImage(),
										 name: postCategory,
										 description: postDescription,
										 category: postProductName,
										 like: postLike)
					self.postsArray.append(post)

					self.favoritesTV.reloadData()
				}
			}
		}
	}
}

// MARK: - Table view data source

extension FavoritesViewController: UITableViewDataSource {

	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return postsArray.count //postNameFavoritesCD.count
	}

	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

		guard let cell = tableView.dequeueReusableCell(withIdentifier: "favoritesCell", for: indexPath) as? FavoritesTableViewCell else {
			fatalError("error")
		}

		let postInfo: PostModel
		postInfo = postsArray[indexPath.row]
		cell.nameFavoritesLabel.text = postInfo.pName
		cell.descriptionFavoritesLabel.text = postInfo.pDescription
		cell.categoryFavoritesLabel.text = postInfo.pCategory
		cell.imageFavorites.image = postInfo.pImage

		return cell
	}
}
