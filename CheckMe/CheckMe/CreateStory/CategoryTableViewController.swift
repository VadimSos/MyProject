//
//  CategoryViewController.swift
//  CheckMe
//
//  Created by Vadzim Sasnouski on 3/10/19.
//  Copyright © 2019 Vadzim Sasnouski. All rights reserved.
//

import UIKit

class CategoryTableViewController: UIViewController, CategoryViewProtocol {

	// MARK: - Variables

	var categoryNames: [String] = []
    var presenter: CategoryPresenterProtocol!

	// MARK: - Lifecycle

	override func viewDidLoad() {
		super.viewDidLoad()
        presenter.setupCategoryView()
	}

	// MARK: - Actiones
    
    func setupCategoryView(data: [CategoryModel]) {
        let item1 = NSLocalizedString(data[0].localizedTitle, comment: "")
        let item2 = NSLocalizedString(data[1].localizedTitle, comment: "")
        let item3 = NSLocalizedString(data[2].localizedTitle, comment: "")
        let item4 = NSLocalizedString(data[3].localizedTitle, comment: "")
        let item5 = NSLocalizedString(data[4].localizedTitle, comment: "")
        let item6 = NSLocalizedString(data[5].localizedTitle, comment: "")
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
        cell.setup(title: categoryNames[indexPath.row])
		tableView.tableFooterView = UIView(frame: .zero)
		return cell
	}

}

extension CategoryTableViewController: UITableViewDelegate {
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		let category = categoryNames[indexPath.row]
        presenter.choose(category: category)
	}
}
