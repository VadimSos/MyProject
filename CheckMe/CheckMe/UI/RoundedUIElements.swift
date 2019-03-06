//
//  RoundedUIElements.swift
//  CheckMe
//
//  Created by Vadzim Sasnouski on 3/6/19.
//  Copyright © 2019 Vadzim Sasnouski. All rights reserved.
//

import UIKit

class RoundButtons: UIButton {
	override func layoutSubviews() {
		super .layoutSubviews()
		layer.cornerRadius = frame.height * 0.2
	}
}
