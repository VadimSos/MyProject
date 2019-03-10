//
//  CreateStoryViewController.swift
//  CheckMe
//
//  Created by Vadzim Sasnouski on 3/7/19.
//  Copyright © 2019 Vadzim Sasnouski. All rights reserved.
//

import UIKit

class CreateStoryViewController: UIViewController, CategoryTableViewControllerDelegate {

	@IBOutlet weak var categoryLabel: UILabel!

	@IBAction func choseCategoryButtonDidTap(_ sender: UIButton) {
	}

	func didCellPressed(category: String) {
		categoryLabel.text = category
	}

	override func viewDidLoad() {
        super.viewDidLoad()
    }

	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if segue.identifier == "showCategoryVC" {
			guard let destinationVC = segue.destination as? CategoryTableViewController else {
				return
			}
			destinationVC.delegate = self
		}
	}

}
