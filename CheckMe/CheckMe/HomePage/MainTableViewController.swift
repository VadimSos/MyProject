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
	var postCD: [NSManagedObject] = []

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
			postCD = try managedContext.fetch(fetchRequest)
		} catch let error as NSError {
			print("Could not fetch. \(error), \(error.userInfo)")
		}

		tableView.reloadData()
	}
}

	// MARK: - Table view data source

extension MainTableViewController: UITableViewDataSource {

	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return postCD.count
	}

	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

		let person = postCD[indexPath.row]
		guard let cell = tableView.dequeueReusableCell(withIdentifier: "homeCell", for: indexPath) as? MainTableViewCell else {
			fatalError("error")
		}

		cell.nameMainVCLabel.text = person.value(forKey: "name") as? String
		cell.descriptionMainVCLabel.text = person.value(forKey: "desciption") as? String
		cell.categoryMainVCLabel.text = person.value(forKey: "category") as? String
//		cell.textLabel?.text = person.value(forKey: "name") as? String
		return cell
	}
}
