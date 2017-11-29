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
	@IBOutlet weak var vibrationSwitch: UISwitch!
	var textFields = [UITextField]()
	
	override func viewDidLoad() {
        super.viewDidLoad()
		provideDefaultValues()
		textFields = [pomodoroField, shortBreakField, longBreakField]
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
		let def = UserDefaults()
		pomodoroField.text = "\(modes[0].seconds)"
		shortBreakField.text = "\(modes[1].seconds)"
		longBreakField.text = "\(modes[2].seconds)"
		vibrationSwitch.isOn = def.bool(forKey: "vibrationSwitch")
	}
	
	func setKeyboards() {
		for f in textFields {
			f.keyboardType = .numberPad
		}
	}
	
	func checkValidity() -> Bool {
		for f in textFields {
			let t = f.text!
			if (t.isEmpty || Int(t) == nil) {
				return false
			}
		}
		return true
	}
	
	func presentAlert() {
		let invalidEntryAlert = UIAlertController(title: "Invalid entry", message: "Please provide valid values.", preferredStyle: UIAlertControllerStyle.alert)
		let dismiss = UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.default, handler: nil)
		invalidEntryAlert.addAction(dismiss)
		self.present(invalidEntryAlert, animated: true, completion: nil)
	}
	
	func saveValues() {
		let def = UserDefaults()
		def.set(Int(textFields[0].text!)!, forKey: "pomodoroSeconds")
		def.set(Int(textFields[1].text!)!, forKey: "shortBreakSeconds")
		def.set(Int(textFields[2].text!)!, forKey: "longBreakSeconds")
		def.set(vibrationSwitch.isOn, forKey: "vibrationSwitch")
	}
	
	func goToTimer() {
		let viewController = self.storyboard?.instantiateViewController(withIdentifier: "timer")
		UIView.transition(from: self.view,
						  to: (viewController?.view)!,
						  duration: 0.4,
						  options: UIViewAnimationOptions.transitionCrossDissolve,
						  completion:
			{ (finished: Bool) -> () in
				self.navigationController?.viewControllers = [viewController!]
		})
	}
	
	@IBAction func saveTouch(_ sender: UIBarButtonItem) {
		if checkValidity() {
			saveValues()
			goToTimer()
		} else {
			presentAlert()
		}
	}
}
