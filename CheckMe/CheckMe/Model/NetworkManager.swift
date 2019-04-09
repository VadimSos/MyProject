//
//  NetworkManager.swift
//  CheckMe
//
//  Created by Vadzim Sasnouski on 4/8/19.
//  Copyright © 2019 Vadzim Sasnouski. All rights reserved.
//

import Foundation
import Reachability

class ConnectionManager {

	static let sharedInstance = ConnectionManager()
	private var reachability: Reachability!

	private init() {}

	func observeReachability() {
		self.reachability = Reachability()
		NotificationCenter.default.addObserver(self, selector: #selector(self.reachabilityChanged), name: NSNotification.Name.reachabilityChanged, object: nil)
		do {
			try self.reachability.startNotifier()
		} catch let error {
			print("Error occured while starting reachability notifications : \(error.localizedDescription)")
		}
	}

	@objc func reachabilityChanged(note: Notification) {
		let reachability = note.object as? Reachability
		switch reachability!.connection {
		case .cellular:
//			self.alert(message: "Connected", from: UIViewController)
			print("Network available via Cellular Data.")
		case .wifi:
//			self.alert(message: "Connected")
			print("Network available via WiFi.")
		case .none:
//			self.alert(message: "Network is not available")
			print("Network is not available.")
		}
	}

	func alert(message: String, from usedVC: UIViewController) {
		let alert = UIAlertController(title: "Alert", message: message, preferredStyle: .alert)
		alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
		usedVC.present(alert, animated: true, completion: nil)
	}
}
