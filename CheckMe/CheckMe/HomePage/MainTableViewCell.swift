//
//  MainTableViewCell.swift
//  CheckMe
//
//  Created by Vadzim Sasnouski on 3/15/19.
//  Copyright © 2019 Vadzim Sasnouski. All rights reserved.
//

import UIKit

class MainTableViewCell: UITableViewCell {

	// MARK: - Outlets

	@IBOutlet weak var nameMainVCLabel: UILabel!
	@IBOutlet weak var descriptionMainVCLabel: UILabel!
	@IBOutlet weak var categoryMainVCLabel: UILabel!
	@IBOutlet weak var imageMainVC: UIImageView!

	override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

	func updateTableView(with item: PostModelProtocol) {
		nameMainVCLabel.text = item.postName()
		descriptionMainVCLabel.text = item.postDescription()
		categoryMainVCLabel.text = item.postCategory()
		imageMainVC.image = item.postImage()
	}

}
