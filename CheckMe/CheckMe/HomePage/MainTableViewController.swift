//
//  MainTableViewController.swift
//  CheckMe
//
//  Created by Vadzim Sasnouski on 3/14/19.
//  Copyright © 2019 Vadzim Sasnouski. All rights reserved.
//

import UIKit
import CoreData
import Firebase

class MainTableViewController: UIViewController {

	// MARK: - Variables

	@IBOutlet weak var tableView: UITableView!
	var postsArray: [PostModel] = []
	var imageArray: [UIImage] = []
	let refDB = Database.database().reference()
	let storage = Storage.storage().reference()

	// MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
		displayPostsMainVC()
    }

	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		tableView.reloadData()
	}

	// MARK: - Actions

	@IBAction func buttonLikeDidTap(_ sender: UIBarButtonItem) {
		tabBarController?.selectedIndex = 1
	}

	func displayPostsMainVC() {

		guard let posts = Auth.auth().currentUser else {
			return
		}

		//download images
		let storageRef = storage.child("posts").child("images").child(posts.uid)

		storageRef.getData(maxSize: 100 * 1024 * 1024) { [weak self] (data, error) in
			guard let data = data else { return }
			if let error = error {
				print(error)
			} else {
				guard let image = UIImage(data: data) else { return }
				self?.imageArray.append(image)

				//download posts
				self?.refDB.child("posts").child(posts.uid).observeSingleEvent(of: .value) { (snapshot) in

					let value = snapshot.value as? [String: Any]
					let postCategory = value?["category"] as? String ?? ""
					let postDescription = value?["description"] as? String ?? ""
					let postProductName = value?["productName"] as? String ?? ""
					let postLike = value?["like"] as? Bool ?? false

					let post = PostModel(image: self?.imageArray.first ?? UIImage(),
										 name: postCategory,
										 description: postDescription,
										 category: postProductName,
										 like: postLike)
					self?.postsArray.append(post)

					self?.tableView.reloadData()
				}
			}
		}
	}
}

	// MARK: - Table view data source

extension MainTableViewController: UITableViewDataSource {

	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return postsArray.count
	}

	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		guard let cell = tableView.dequeueReusableCell(withIdentifier: "homeCell", for: indexPath) as? MainTableViewCell else {
			fatalError("error")
		}

		cell.updateTableView(with: postsArray[indexPath.row])

		return cell
	}
}
