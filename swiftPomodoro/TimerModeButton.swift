//
//  TimerModeButton.swift
//  swiftPomodoro
//
//  Created by Sarp Guney on 24.11.2017.
//  Copyright © 2017 Sarp Guney. All rights reserved.
//

import UIKit

class TimerModeButton: UIButton {
	
	let blue = UIColor.init(red: 0, green: 0.5, blue: 1, alpha: 1)
	let darkBlue = UIColor.init(red: 0, green: 0.3, blue: 0.8, alpha: 1)
	
	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
		self.layer.borderWidth = 1
		self.backgroundColor = blue
		self.setTitleColor(UIColor.white, for: .normal)
	}
	
	var chosen: Bool = false {
		didSet {
			if chosen {
				self.backgroundColor = darkBlue
			} else {
				self.backgroundColor = blue
			}
		}
	}
}
