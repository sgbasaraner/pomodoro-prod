//
//  TimerModeButton.swift
//  swiftPomodoro
//
//  Created by Sarp Guney on 24.11.2017.
//  Copyright © 2017 Sarp Guney. All rights reserved.
//

import UIKit

class TimerModeButton: UIButton {
	
	let blue = UIColor(red:0.36, green:0.65, blue:0.90, alpha:1.0)
	let darkBlue = UIColor(red:0.13, green:0.52, blue:0.73, alpha:1.0)
	
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
