//
//  CreateStoryTableViewCell.swift
//  CheckMe
//
//  Created by Vadzim Sasnouski on 3/10/19.
//  Copyright © 2019 Vadzim Sasnouski. All rights reserved.
//

import UIKit

class CategoryTableViewCell: UITableViewCell {

	@IBOutlet weak var titleLabel: UILabel!

    func setup(title: String?) {
        self.titleLabel.text = title
    }
}
