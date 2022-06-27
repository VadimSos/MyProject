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
    private var content: [Section] = []

    var viewModel: SettingsViewModelProtocol?
    var viewData: SettingsUserData.UserData?

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

        viewModel?.getUserData()
        rebuildContent()

        viewModel?.updateTable = { [weak self] data in
            switch data {
            case.success(let user):
                self?.viewData = user
                self?.rebuildContent()
            default:
                break
            }
        }
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
                                           detail: viewData?.name),
                          reuseIdentifier: SettingsInfoCell.reuseIdentifier,
                          action: nil,
                          isEnabled: true)

        let familyNameRow = Row(content: .simple(text: "Fmaily Name",
                                                 detail: viewData?.familyName),
                          reuseIdentifier: SettingsInfoCell.reuseIdentifier,
                          action: nil,
                          isEnabled: true)

        let phoneNUmber = Row(content: .simple(text: "Phone number",
                                               detail: viewData?.phoneNumber),
                          reuseIdentifier: SettingsInfoCell.reuseIdentifier,
                          action: nil,
                          isEnabled: true)

        let secondPhoneNUmber = Row(content: .simple(text: "Second phone number",
                                                     detail: viewData?.additionalPhoneNumber),
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
            if let viewController = viewController as? SettingsPickerCellVC {
                if indexPath.row == 0 {
                    viewController.setup(type: .datePicker)
                } else if indexPath.row == 1 {
                    viewController.setup(type: .viewPicker)
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
