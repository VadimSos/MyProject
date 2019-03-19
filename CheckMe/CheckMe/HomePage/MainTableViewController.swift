//
//  MainTableViewController.swift
//  CheckMe
//
//  Created by Vadzim Sasnouski on 3/14/19.
//  Copyright © 2019 Vadzim Sasnouski. All rights reserved.
//

import UIKit
import CoreData

class MainTableViewController: UIViewController {

	// MARK: - Variables

	@IBOutlet weak var tableView: UITableView!
	var postNameCD: [Post] = []

	// MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
    }

	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)

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
		return postNameCD.count
	}

	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

		let name: Post = postNameCD[indexPath.row]
		guard let cell = tableView.dequeueReusableCell(withIdentifier: "homeCell", for: indexPath) as? MainTableViewCell else {
			fatalError("error")
		}

		cell.nameMainVCLabel.text = name.name// value(forKey: "name") as? String
		cell.descriptionMainVCLabel.text = name.desciption//.value(forKey: "desciption") as? String
		cell.categoryMainVCLabel.text = name.category //.value(forKey: "category") as? String

		return cell
	}
}
