//
//  CategoryViewController.swift
//  CheckMe
//
//  Created by Vadzim Sasnouski on 3/10/19.
//  Copyright © 2019 Vadzim Sasnouski. All rights reserved.
//

import UIKit

protocol CategoryTableViewControllerDelegate: class {
	func didCellPressed(category: String)
}

class CategoryTableViewController: UIViewController {

	// MARK: - Variables

	var categoryNames: [String] = []
	weak var delegate: CategoryTableViewControllerDelegate?

	// MARK: - Lifecycle

	override func viewDidLoad() {
		super.viewDidLoad()
		setupTableViewData()
	}

	// MARK: - Actiones

	func setupTableViewData() {
		let item1 = NSLocalizedString("Sport", comment: "")
		let item2 = NSLocalizedString("Gas", comment: "")
		let item3 = NSLocalizedString("Taxi", comment: "")
		let item4 = NSLocalizedString("Foot", comment: "")
		let item5 = NSLocalizedString("Medicine", comment: "")
		let item6 = NSLocalizedString("Treatment", comment: "")
		categoryNames = [item1, item2, item3, item4, item5, item6]
	}

}

// MARK: - Extensions

extension CategoryTableViewController: UITableViewDataSource {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return categoryNames.count
	}

	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		guard let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath) as? CategoryTableViewCell else {
			fatalError("Fatal Error")
		}
		cell.textLabel?.text = categoryNames[indexPath.row]
		tableView.tableFooterView = UIView(frame: .zero)
		return cell
	}

}

extension CategoryTableViewController: UITableViewDelegate {
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		let category = categoryNames[indexPath.row]
		delegate?.didCellPressed(category: category)

		navigationController?.popViewController(animated: true)
	}
}
