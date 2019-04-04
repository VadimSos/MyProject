//
//  SettingsViewController.swift
//  CheckMe
//
//  Created by Vadzim Sasnouski on 3/7/19.
//  Copyright © 2019 Vadzim Sasnouski. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseCore
import FirebaseDatabase

class SettingsTableViewController: UIViewController {

	// MARK: - Variables

	@IBOutlet weak var mailLabel: UILabel!
	@IBOutlet weak var tableView: UITableView!
	var userData: [[String]] = []
	let headers = [" ", " ", " ", " "]
	let ref = Database.database().reference()

	// MARK: - Lifecycle

	override func viewDidLoad() {
        super.viewDidLoad()
		mailLabel.text = Auth.auth().currentUser?.email
		setupTableViewData()
    }

	// MARK: - Actiones

	func setupTableViewData() {

		guard let userID = Auth.auth().currentUser?.uid else { return }

		ref.child("users").child(userID).observeSingleEvent(of: .value, with: { (snapshot) in
		let value = snapshot.value as? [String: Any]
		let userName = value?["name"] as? String ?? ""
		let userFamilyName = value?["familyName"] as? String ?? ""
		let userCellPhoneNumber = value?["cellPhoneNumber"] as? String ?? ""
		let userPhoneNumber = value?["phoneNumber"] as? String ?? ""

			let item1 = userName
			let item2 = userFamilyName
			let item3 = userCellPhoneNumber
			let item4 = userPhoneNumber
			let item5 = NSLocalizedString("Date of birth", comment: "")
			let item6 = NSLocalizedString("Gender", comment: "")
			let item7 = NSLocalizedString("Password", comment: "")
			let item8 = NSLocalizedString("Logout", comment: "")

			self.userData = [[item1, item2, item3, item4], [item5, item6], [item7], [item8]]
			self.tableView.reloadData()
		})
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

		if indexPath.section == 3 {
			let myAlert = UIAlertController(title: NSLocalizedString("Logout", comment: ""),
											message: NSLocalizedString("Are you sure to exit?", comment: ""),
											preferredStyle: UIAlertController.Style.alert)
			myAlert.addAction(UIAlertAction(title: NSLocalizedString("Cancel", comment: ""),
											style: UIAlertAction.Style.cancel,
											handler: nil))
			myAlert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: ""),
											style: UIAlertAction.Style.default,
											handler: { _ in
				let firebaseAuth = Auth.auth()
				do {
					try firebaseAuth.signOut()
				} catch let signOutError as NSError {
					print ("Error signing out: %@", signOutError)
				}

				let storyboard = UIStoryboard(name: "Login", bundle: nil)
				let logout = storyboard.instantiateViewController(withIdentifier: "WelcomViewController") as UIViewController
				self.present(logout, animated: true, completion: nil)
			}))

			self.present(myAlert, animated: true, completion: nil)
		}
	}
}
