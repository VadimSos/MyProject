//
//  WelcomViewController.swift
//  CheckMe
//
//  Created by Vadzim Sasnouski on 3/27/19.
//  Copyright © 2019 Vadzim Sasnouski. All rights reserved.
//

import UIKit
import Reachability

class WelcomViewController: UIViewController {

	var reachability: Reachability?

    override func viewDidLoad() {
        super.viewDidLoad()

		self.reachability = Reachability.init()

		if (self.reachability?.connection) != .none {
			print("Internet Available")
		} else {
			print("Internet not Available")
		}
    }
}
