//
//  SettingsTableContentControllerCell.swift
//  CheckMe
//
//  Created by Vadim Sosnovsky on 22.06.22.
//  Copyright © 2022 Vadzim Sasnouski. All rights reserved.
//

import UIKit

class SettingsTableContentControllerCell: UITableViewCell {

    static let reuseIdentifier: String = "TableContentControllerCell"

    weak var viewController: UIViewController? {
        didSet {
            reloadData()
        }
    }

    private func reloadData() {

        guard let vc = viewController else {
            return
        }
        
        vc.view.frame = contentView.bounds
        contentView.addSubview(vc.view)
        vc.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        vc.view.translatesAutoresizingMaskIntoConstraints = true
    }

    override func prepareForReuse() {
        super.prepareForReuse()

        releaseViewController()
    }

    private func releaseViewController() {
        contentView.subviews.forEach({ $0.removeFromSuperview() })
    }
}
