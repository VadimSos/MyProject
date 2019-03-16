//
//  SettingsViewController.swift
//  CheckMe
//
//  Created by Vadzim Sasnouski on 3/7/19.
//  Copyright © 2019 Vadzim Sasnouski. All rights reserved.
//

import UIKit

class SettingsTableViewController: UIViewController {

	// MARK: - Variables

	@IBOutlet weak var mailLabel: UILabel!
	var userData: [[String]] = []
	let headers = [" ", " ", " ", " "]

	// MARK: - Lifecycle

	override func viewDidLoad() {
        super.viewDidLoad()
		mailLabel.text = UserDefaults.standard.string(forKey: "MyMail")
		setupTableViewData()
    }

	// MARK: - Actiones

	func setupTableViewData() {
		let item1 = "Вадим"
		let item2 = "Сосновский"
		let item3 = "+375295123456"
		let item4 = "+375172342312"
		let item5 = "Date of birth"
		let item6 = "Gender"
		let item7 = "Password"
		let item8 = "Logout"

		userData = [[item1, item2, item3, item4], [item5, item6], [item7], [item8]]
	}
}

	// MARK: - UITableViewDataSource

extension SettingsTableViewController: UITableViewDataSource {

	func numberOfSections(in tableView: UITableView) -> Int {
		return userData.count
	}

	func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
		if section < headers.count {
			return headers[section]
		}
		return nil
	}

	func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
		if section < headers.count {
			return headers[section]
		}
		return nil
	}

	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return userData[section].count
	}

	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "contactInfoCell", for: indexPath)

		cell.textLabel?.text = userData[indexPath.section][indexPath.row]
		tableView.tableFooterView = UIView(frame: .zero)
		return cell
	}

}

extension SettingsTableViewController: UITableViewDelegate {

	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		let passwordRow = indexPath
		if passwordRow.section == 2 {
				self.performSegue(withIdentifier: "changePasswordID", sender: self)
		}
	}
}
