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
//import AUPickerCell

class SettingsTableViewController: UIViewController {

	// MARK: - Variables

	@IBOutlet weak var mailLabel: UILabel!
	@IBOutlet weak var tableView: UITableView!
    private var content: [Section] = []
    
	var userData: [[String]] = []
	let headers = [" ", " ", " ", " "]
	let ref = Database.database().reference()
    
    private struct Row {
        enum ContentType {
            case simple(text: String, detail: String?)
            case custom(viewController: UIViewController)
        }
        
        let content: ContentType
        let reuseIdentifier: String
        let action: (() -> Void)?
        let isEnabled: Bool
    }
    
    private struct Section {
        let headerTitle: String?
        let rows: [Row]
        let footerTitle: String?

        init(headerTitle: String? = nil, row: Row, footerTitle: String?) {
            self.headerTitle = headerTitle
            self.rows = [row]
            self.footerTitle = footerTitle
        }

        init(headerTitle: String? = nil, row: [Row], footerTitle: String?) {
            self.headerTitle = headerTitle
            self.rows = row
            self.footerTitle = footerTitle
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        rebuildContent()
    }

    private func registerCellsAndReloadData() {
        guard isViewLoaded else { return }

        tableView.register(UINib(nibName: String(describing: SettingsInfoCell.self),
                                 bundle: nil),
                           forCellReuseIdentifier: SettingsInfoCell.reuseIdentifier)

        tableView.register(UINib(nibName: String(describing: SettingsPickerCellVC.self),
                                 bundle: nil),
                           forCellReuseIdentifier: SettingsPickerCellVC.reuseIdentifier)

        tableView.register(UINib(nibName: String(describing: SettingsTableActionCell.self),
                                 bundle: nil),
                           forCellReuseIdentifier: SettingsTableActionCell.reuseIdentifier)

        tableView.register(SettingsTableContentControllerCell.self,
                           forCellReuseIdentifier: SettingsTableContentControllerCell.reuseIdentifier)

        tableView.reloadData()
    }

    private func rebuildContent() {
        content = []

        content.append(mainSection())
        content.append(pickerSection())
        content.append(passwordSection())
        content.append(logoutSection())

        registerCellsAndReloadData()
    }

    private func mainSection() -> Section {
        var rows: [Row] = []

        let nameRow = Row(content: .simple(text: "Name",
                                           detail: nil),
                          reuseIdentifier: SettingsInfoCell.reuseIdentifier,
                          action: nil,
                          isEnabled: true)

        let familyNameRow = Row(content: .simple(text: "Fmaily Name",
                                           detail: nil),
                          reuseIdentifier: SettingsInfoCell.reuseIdentifier,
                          action: nil,
                          isEnabled: true)

        let phoneNUmber = Row(content: .simple(text: "Phone number",
                                           detail: nil),
                          reuseIdentifier: SettingsInfoCell.reuseIdentifier,
                          action: nil,
                          isEnabled: true)

        let secondPhoneNUmber = Row(content: .simple(text: "Second phone number",
                                           detail: nil),
                          reuseIdentifier: SettingsInfoCell.reuseIdentifier,
                          action: nil,
                          isEnabled: true)

        rows.append(nameRow)
        rows.append(familyNameRow)
        rows.append(phoneNUmber)
        rows.append(secondPhoneNUmber)

        return Section(headerTitle: nil, row: rows, footerTitle: nil)
    }

    private func pickerSection() -> Section {
        var rows: [Row] = []

        let birthDateAction = { [weak self] in

        }

        let genderAction = { [weak self] in

        }

        let birthDate = Row(content: .custom(viewController: SettingsPickerCellVC()),
                          reuseIdentifier: SettingsTableContentControllerCell.reuseIdentifier,
                          action: birthDateAction,
                          isEnabled: true)

        let gender = Row(content: .custom(viewController: SettingsPickerCellVC()),
                          reuseIdentifier: SettingsTableContentControllerCell.reuseIdentifier,
                          action: genderAction,
                          isEnabled: true)

        rows.append(birthDate)
        rows.append(gender)

        return Section(headerTitle: nil, row: rows, footerTitle: nil)
    }

    private func passwordSection() -> Section {

        let action = { [weak self] in
            let view = self?.storyboard?.instantiateViewController(withIdentifier: "cahngePasswordVC") as? ChangePasswordViewController
            let firebase = FirebaseService()
            let viewModel = ChangePasswordViewModel(firebaseService: firebase)
            view?.changePasswordViewModel = viewModel
            viewModel.updateViewForInitial()
            self?.present(view!, animated: true)

        }

        let changePasswordRow = Row(content: .simple(text: "Password",
                                           detail: nil),
                          reuseIdentifier: SettingsTableActionCell.reuseIdentifier,
                          action: action,
                          isEnabled: true)

        return Section(headerTitle: nil, row: changePasswordRow, footerTitle: nil)
    }

    private func logoutSection() -> Section {

        let action = { [weak self] in
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

                let navigationController = UINavigationController()
                let builder = ModuleBuilder()
                let router = Router(navigationController: navigationController, builder: builder)
                router.initialViewController()
                navigationController.modalPresentationStyle = .fullScreen
                self?.present(navigationController, animated: true) {
                    self?.tabBarController?.view.removeFromSuperview()
                }
            }))

            self?.present(myAlert, animated: true, completion: nil)
        }

        let logoutRow = Row(content: .simple(text: "Logout",
                                           detail: nil),
                          reuseIdentifier: SettingsTableActionCell.reuseIdentifier,
                          action: action,
                          isEnabled: true)

        return Section(headerTitle: nil, row: logoutRow, footerTitle: nil)
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
        return content.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return content[section].rows.count
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        content[section].headerTitle
    }

    func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        content[section].footerTitle
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let row = content[indexPath.section].rows[indexPath.row]

        switch row.content {
        case .simple(text: let text, detail: let detail):
            let cell = tableView.dequeueReusableCell(withIdentifier: row.reuseIdentifier, for: indexPath)
            (cell as? SettingsInfoCell)?.setup(title: text, detail: detail)
            (cell as? SettingsTableActionCell)?.setup(title: text, detail: detail)
            return cell

        case .custom(viewController: let viewController):
            let cell = tableView.dequeueReusableCell(withIdentifier: row.reuseIdentifier, for: indexPath)
            (cell as? SettingsTableContentControllerCell)?.viewController = viewController
            if let vc = viewController as? SettingsPickerCellVC {
                if indexPath.row == 0 {
                    vc.setup(type: .datePicker)
                } else if indexPath.row == 1 {
                    vc.setup(type: .viewPicker)
                }
            }
            return cell
        }
    }
}

	// MARK: - UITableViewDelegate

extension SettingsTableViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

        let row = content[indexPath.section].rows[indexPath.row]
        if row.isEnabled {
            row.action?()
        }
    }

	func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		return 44
	}
}
