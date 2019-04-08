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
//	var postNameCD: [Post] = []
	var postsArray: [PostModel] = []
	var imageArray: [UIImage] = []
	let refDB = Database.database().reference()
	let storage = Storage.storage().reference()

	// MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
		displayPosts()
    }

	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		tableView.reloadData()
		}

	func displayPosts() {

		guard let posts = Auth.auth().currentUser else {
			return
		}

		//download images
		let storageRef = storage.child("posts").child("images").child(posts.uid)

		storageRef.getData(maxSize: 15 * 1024 * 1024) { (data, error) in
			if let error = error {
				print(error)
			} else {
				let image = UIImage(data: data!)
				self.imageArray.append(image!)
			}
		}

		//download posts
		refDB.child("posts").child(posts.uid).observeSingleEvent(of: .value) { (snapshot) in
			
			let value = snapshot.value as? [String: Any]
			let postCategory = value?["category"] as? String ?? ""
			let postDescription = value?["description"] as? String ?? ""
			let postProductName = value?["productName"] as? String ?? ""

			let post = PostModel(image: self.imageArray.first ?? UIImage(), name: postCategory, description: postDescription, category: postProductName)
			self.postsArray.append(post)
//			self.postsArray = [postCategory, postDescription, postProductName]

			self.tableView.reloadData()
	}

		/*
		guard let appDelegate =
		UIApplication.shared.delegate as? AppDelegate else {
		return
		}
		let managedContext =
		appDelegate.persistentContainer.viewContext
		
		let fetchRequest =
		NSFetchRequest<NSManagedObject>(entityName: "Post")
		
		do {
		postNameCD = try managedContext.fetch(fetchRequest) as? [Post] ?? []
		} catch let error as NSError {
		print("Could not fetch. \(error), \(error.userInfo)")
		}
	*/
		tableView.reloadData()
	}

	@IBAction func addPostToFavorites(_ sender: UIBarButtonItem) {
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

		let postInfo: PostModel
		postInfo = postsArray[indexPath.row]
		cell.nameMainVCLabel.text = postInfo.pName
		cell.descriptionMainVCLabel.text = postInfo.pDescription
		cell.categoryMainVCLabel.text = postInfo.pCategory
		cell.imageMainVC.image = postInfo.pImage

		/*
		let name: Post = postNameCD[indexPath.row]
		cell.nameMainVCLabel.text = name.name// value(forKey: "name") as? String
		cell.descriptionMainVCLabel.text = name.desciption//.value(forKey: "desciption") as? String
		cell.categoryMainVCLabel.text = name.category //.value(forKey: "category") as? String
		*/

		return cell
	}
}
