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

    }

	func alert(message: String) {
		let alert = UIAlertController(title: "Netowrk status", message: message, preferredStyle: .alert)
		alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
		self.present(alert, animated: true, completion: nil)
	}

	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)

		self.reachability = Reachability.init()

		if (self.reachability?.connection) != .none {
			self.alert(message: "Connected")
			print("Internet Available")
		} else {
			self.alert(message: "Network is not available")
			print("Internet not Available")
		}
	}
}
