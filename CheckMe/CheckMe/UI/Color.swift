//
//  Color.swift
//  CheckMe
//
//  Created by Vadzim Sasnouski on 3/10/19.
//  Copyright © 2019 Vadzim Sasnouski. All rights reserved.
//

import UIKit

class ColorLabels: UILabel {
	override func layoutSubviews() {
		super .layoutSubviews()
		self.textColor = UIColor.init(red: 0.275, green: 0.486, blue: 0.141, alpha: 1.0)
	}
}

extension UIColor {

	static func magnezium() -> UIColor {
		return UIColor.init(red: 0.754, green: 0.754, blue: 0.754, alpha: 1.0)
	}
    
    static var tabBatItemAccent: UIColor {
        #colorLiteral(red: 1, green: 0.5764705882, blue: 0, alpha: 1)
    }
}
