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
import DZNEmptyDataSet

class FavoritesViewController: UIViewController {

	// MARK: - Variables

	@IBOutlet weak var favoritesTV: UITableView!
	var postsArray: [PostModel] = []
	var imageArray: [UIImage] = []
	let refDB = Database.database().reference()
	let storage = Storage.storage().reference()

	// MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
		configureView()
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
			guard let data = data else { return }
			if let error = error {
				print(error)
			} else {
				guard let image = UIImage(data: data) else { return }
				self.imageArray.append(image)

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

// MARK: - DZNEmptyDataSetSource, DZNEmptyDataSetDelegate

extension FavoritesViewController: DZNEmptyDataSetSource, DZNEmptyDataSetDelegate {

	func configureView() {
		// Update the user interface for the detail item.
		favoritesTV.emptyDataSetSource = self
		favoritesTV.emptyDataSetDelegate = self

		// Removing the cell separators
		favoritesTV.tableFooterView = UIView()
	}

	func image(forEmptyDataSet scrollView: UIScrollView!) -> UIImage! {
		return UIImage(named: "EmptyPage")
	}

	func title(forEmptyDataSet scrollView: UIScrollView!) -> NSAttributedString! {
		let str = "No Posts"
		let attrs = [NSAttributedString.Key.font: UIFont.preferredFont(forTextStyle: UIFont.TextStyle.headline)]
		return NSAttributedString(string: str, attributes: attrs)
	}

	func description(forEmptyDataSet scrollView: UIScrollView) -> NSAttributedString? {
		let str = "When you chose posts, you'll see them here."
		let attrs = [NSAttributedString.Key.font: UIFont.preferredFont(forTextStyle: UIFont.TextStyle.body)]
		return NSAttributedString(string: str, attributes: attrs)
	}

	func backgroundColor(forEmptyDataSet scrollView: UIScrollView!) -> UIColor! {
		return UIColor.init(red: 0.837, green: 0.837, blue: 0.837, alpha: 1)
	}

	func buttonTitle(forEmptyDataSet scrollView: UIScrollView!, for state: UIControl.State) -> NSAttributedString! {
		let str = "Like Post"
		let attrs = [NSAttributedString.Key.font: UIFont.preferredFont(forTextStyle: .callout)]
		return NSAttributedString(string: str, attributes: attrs)
	}

	func emptyDataSet(_ scrollView: UIScrollView!, didTap button: UIButton!) {
		//Open CreatePost VC
		tabBarController?.selectedIndex = 0
	}
}
