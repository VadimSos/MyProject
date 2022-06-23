//
//  SettingsInfoCellVC.swift
//  CheckMe
//
//  Created by Vadim Sosnovsky on 22.06.22.
//  Copyright © 2022 Vadzim Sasnouski. All rights reserved.
//

import UIKit

class SettingsInfoCell: UITableViewCell {

    static let reuseIdentifier: String = "SettingsInfoCell"

    @IBOutlet weak var titleLabel: UILabel!
}

extension SettingsInfoCell {
    func setup(title: String?, detail: String?) {
        self.titleLabel.text = title
    }
}
