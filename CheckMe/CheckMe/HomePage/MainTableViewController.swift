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
	var postNameCD: [Post] = []
	var postsArray: [String] = []
	let ref = Database.database().reference()

	// MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
		displayPosts()
    }

	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		}

	func displayPosts() {

//		guard let posts = Auth.auth().currentUser else {
//			return
//		}
//
//		ref.child("posts").child(posts.uid).observeSingleEvent(of: .value) { (snapshot) in
//			let value = snapshot.value as? [String: Any]
//			let postCategory = value?["category"] as? String ?? ""
//			let postDescription = value?["description"] as? String ?? ""
//			let postProductName = value?["productName"] as? String ?? ""
//
//			self.postsArray = [postCategory, postDescription, postProductName]
//	}


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

//		let postInfo = postsArray[indexPath.row]
//		cell.nameMainVCLabel.text = postInfo[(cell.nameMainVCLabel.text)?]
//		cell.descriptionMainVCLabel.text = postInfo
//		cell.categoryMainVCLabel.text = postInfo

		let name: Post = postNameCD[indexPath.row]
		cell.nameMainVCLabel.text = name.name// value(forKey: "name") as? String
		cell.descriptionMainVCLabel.text = name.desciption//.value(forKey: "desciption") as? String
		cell.categoryMainVCLabel.text = name.category //.value(forKey: "category") as? String

		return cell
	}
}
