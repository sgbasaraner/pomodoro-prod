//
//  SettingsViewController.swift
//  swiftPomodoro
//
//  Created by Sarp Guney on 28.11.2017.
//  Copyright © 2017 Sarp Guney. All rights reserved.
//

import UIKit
import AVFoundation

class SettingsViewController: UITableViewController, IsSettings {

	// IBOutlet variables
	
	@IBOutlet weak private var pomodoroField: UITextField!
	@IBOutlet weak private var shortBreakField: UITextField!
	@IBOutlet weak private var longBreakField: UITextField!
	@IBOutlet weak private var vibrationSwitch: UISwitch!
	@IBOutlet weak private var alertSoundLabel: UILabel!
	
	// Class variables
	
	private var textFields = [UITextField]()
	private var audioPlayer: AVAudioPlayer? = nil
	private let soundOP = SoundOperator()
	
	// Lifecycle methods
	
	override func viewDidLoad() {
        super.viewDidLoad()
		provideDefaultValues()
		alertSoundLabel.text = soundOP.getCurrentSoundFormatted()
		textFields = [pomodoroField, shortBreakField, longBreakField]
		setKeyboards()
    }
	
	// Table view functions

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		if section == 0 {
			return 3
		} else if section == 1 {
			return 2
		} else {
			return 1
		}
    }
	
	override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		if indexPath.section == 2 && indexPath.row == 0 {
			let alert = UIAlertController(title: "Reset to defaults?", message: "This will replace all of your settings with the default ones.", preferredStyle: UIAlertControllerStyle.alert)
			let ok = UIAlertAction(title: "OK", style: UIAlertActionStyle.default) { (action:UIAlertAction!) in
				// reset to defaults and go to timer
				let def = UserDefaults()
				def.set(1500, forKey: "pomodoroSeconds")
				def.set(300, forKey: "shortBreakSeconds")
				def.set(600, forKey: "longBreakSeconds")
				def.set(false, forKey: "vibrationSwitch")
				def.set(0, forKey: "alertSound")
				PomodoroTimer.shared.stopTimer()
				self.goToTimer()
			}
			let cancel = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.default, handler: nil)
			alert.addAction(ok)
			alert.addAction(cancel)
			present(alert, animated: true, completion: nil)
		}
	}
	
	// IsSettings protocol API
	
	func setAlertSoundLabel(){
		if PomodoroTimer.shared.temporarySoundIndex != nil {
			alertSoundLabel.text = soundOP.formatSound(sound: PomodoroTimer.shared.temporarySoundIndex!)
		}
	}
	
	func playSound() {
		let url = soundOP.getSoundURL(sound: PomodoroTimer.shared.temporarySoundIndex!)
		audioPlayer = try! AVAudioPlayer(contentsOf: url)
		audioPlayer!.play()
	}
	
	// Private implementation
	
	private func provideDefaultValues() {
		let modes = TimerMode.generateTimerModes()
		let def = UserDefaults()
		pomodoroField.text = "\(modes[0].seconds / 60)"
		shortBreakField.text = "\(modes[1].seconds / 60)"
		longBreakField.text = "\(modes[2].seconds / 60)"
		vibrationSwitch.isOn = def.bool(forKey: "vibrationSwitch")
	}
	
	private func setKeyboards() {
		for f in textFields {
			f.keyboardType = .numberPad
		}
	}
	
	private func checkValidity() -> Bool {
		for f in textFields {
			let t = f.text!
			if (t.isEmpty || Int(t) == nil) {
				return false
			}
		}
		return true
	}
	
	private func presentAlert() {
		let invalidEntryAlert = UIAlertController(title: "Invalid entry", message: "Please provide valid values.", preferredStyle: UIAlertControllerStyle.alert)
		let dismiss = UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.default, handler: nil)
		invalidEntryAlert.addAction(dismiss)
		self.present(invalidEntryAlert, animated: true, completion: nil)
	}
	
	private func saveValues() {
		let def = UserDefaults()
		def.set(Int(textFields[0].text!)! * 60, forKey: "pomodoroSeconds")
		def.set(Int(textFields[1].text!)! * 60, forKey: "shortBreakSeconds")
		def.set(Int(textFields[2].text!)! * 60, forKey: "longBreakSeconds")
		def.set(vibrationSwitch.isOn, forKey: "vibrationSwitch")
		if PomodoroTimer.shared.temporarySoundIndex != nil {
			def.set(PomodoroTimer.shared.temporarySoundIndex!, forKey: "alertSound")
		}
	}
	
	private func goToTimer() {
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
	
	@IBAction private func saveTouch(_ sender: UIBarButtonItem) {
		if checkValidity() {
			saveValues()
			PomodoroTimer.shared.temporarySoundIndex = nil
			PomodoroTimer.shared.stopTimer()
			goToTimer()
		} else {
			presentAlert()
		}
	}
}
