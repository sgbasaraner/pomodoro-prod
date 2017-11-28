//
//  SettingsViewController.swift
//  swiftPomodoro
//
//  Created by Sarp Guney on 28.11.2017.
//  Copyright © 2017 Sarp Guney. All rights reserved.
//

import UIKit

class SettingsViewController: UITableViewController {

	@IBOutlet weak var pomodoroField: UITextField!
	@IBOutlet weak var shortBreakField: UITextField!
	@IBOutlet weak var longBreakField: UITextField!
	@IBOutlet weak var vibrationField: UITextField!
	var timerModeFields = [UITextField]()
	var textFields = [UITextField]()
	
	override func viewDidLoad() {
        super.viewDidLoad()
		provideDefaultValues()
		timerModeFields = [pomodoroField, shortBreakField, longBreakField]
		textFields = [pomodoroField, shortBreakField, longBreakField, vibrationField]
		setKeyboards()
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		if section == 0 {
			return 3
		} else {
			return 2
		}
    }
	
	func provideDefaultValues() {
		let modes = generateTimerModes()
		pomodoroField.text = "\(modes[0].seconds)"
		shortBreakField.text = "\(modes[1].seconds)"
		longBreakField.text = "\(modes[2].seconds)"
		vibrationField.text = "3"
	}
	
	func setKeyboards() {
		for f in textFields {
			f.keyboardType = .numberPad
		}
	}
	
	@IBAction func saveTouch(_ sender: UIBarButtonItem) {
		for f in timerModeFields {
			print(f.text)
		}
	}
}
