//
//  SettingsTableActionCellVC.swift
//  CheckMe
//
//  Created by Vadim Sosnovsky on 22.06.22.
//  Copyright © 2022 Vadzim Sasnouski. All rights reserved.
//

import Foundation
import UIKit

class SettingsTableActionCell: UITableViewCell {

    static let reuseIdentifier: String = "SettingsTableActionCell"
    @IBOutlet weak var titleLabel: UILabel!

}

extension SettingsTableActionCell {
    func setup(title: String?, detail: String?) {
        self.titleLabel.text = title
    }
}
