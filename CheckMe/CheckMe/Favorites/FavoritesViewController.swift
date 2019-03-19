//
//  FavoritesViewController.swift
//  CheckMe
//
//  Created by Vadzim Sasnouski on 3/7/19.
//  Copyright © 2019 Vadzim Sasnouski. All rights reserved.
//

import UIKit
import CoreData

class FavoritesViewController: UIViewController {

	// MARK: - Variables

	@IBOutlet weak var favoritesTV: UITableView!
	var postNameFavoritesCD: [Post] = []

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
			postNameFavoritesCD = try managedContext.fetch(fetchRequest) as? [Post] ?? []
		} catch let error as NSError {
			print("Could not fetch. \(error), \(error.userInfo)")
		}

		favoritesTV.reloadData()
	}
}

// MARK: - Table view data source

extension FavoritesViewController: UITableViewDataSource {

	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return postNameFavoritesCD.count
	}

	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

		let name: Post = postNameFavoritesCD[indexPath.row]
		guard let cell = tableView.dequeueReusableCell(withIdentifier: "favoritesCell", for: indexPath) as? FavoritesTableViewCell else {
			fatalError("error")
		}

		cell.nameFavoritesLabel.text = name.name// value(forKey: "name") as? String
		cell.descriptionFavoritesLabel.text = name.desciption//.value(forKey: "desciption") as? String
		cell.categoryFavoritesLabel.text = name.category //.value(forKey: "category") as? String

		return cell
	}
}
