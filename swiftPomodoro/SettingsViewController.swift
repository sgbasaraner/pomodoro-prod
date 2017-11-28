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
	
	override func viewDidLoad() {
        super.viewDidLoad()
		timerModeFields = [pomodoroField, shortBreakField, longBreakField]
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
	
	@IBAction func saveTouch(_ sender: UIBarButtonItem) {
		for f in timerModeFields {
			print(f.text)
		}
	}
}
