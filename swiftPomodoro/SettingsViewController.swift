//
//  SettingsViewController.swift
//  swiftPomodoro
//
//  Created by Sarp Guney on 28.11.2017.
//  Copyright © 2017 Sarp Guney. All rights reserved.
//

import UIKit
import AVFoundation

class SettingsViewController: UITableViewController {

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
        if indexPath.section == 1 && indexPath.row == 1 {
            performSegue(withIdentifier: "toAlertSound", sender: nil)
        }
        
		if indexPath.section == 2 && indexPath.row == 0 {
			let alert = UIAlertController(title: "Reset to defaults?", message: "This will replace all of your settings with the default ones.", preferredStyle: UIAlertControllerStyle.alert)
			let ok = UIAlertAction(title: "OK", style: UIAlertActionStyle.default) { [weak self] (action:UIAlertAction!) in
				// reset to defaults and go to timer
				let def = UserDefaults()
				def.set(1500, forKey: "pomodoroSeconds")
				def.set(300, forKey: "shortBreakSeconds")
				def.set(600, forKey: "longBreakSeconds")
				def.set(false, forKey: "vibrationSwitch")
				def.set(0, forKey: "alertSound")
				PomodoroTimer.shared.stopTimer()
				self?.navigationController?.popViewController(animated: true)
			}
			let cancel = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.default, handler: nil)
			alert.addAction(ok)
			alert.addAction(cancel)
			present(alert, animated: true, completion: nil)
		}
	}
	
	// Private implementation
	
	private func provideDefaultValues() {
		let modes = TimerMode.allModes
		let def = UserDefaults()
		pomodoroField.text = "\(modes[0].seconds / 60)"
		shortBreakField.text = "\(modes[1].seconds / 60)"
		longBreakField.text = "\(modes[2].seconds / 60)"
		vibrationSwitch.isOn = def.bool(forKey: "vibrationSwitch")
	}
	
	private func setKeyboards() {
        textFields.forEach { $0.keyboardType = .numberPad }
	}
	
	private func checkValidity() -> Bool {
		for f in textFields {
            guard let text = f.text else { return false }
			if (text.isEmpty || Int(text) == nil) {
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
		if let idx = PomodoroTimer.shared.temporarySoundIndex {
			def.set(idx, forKey: "alertSound")
		}
	}
	
	@IBAction private func saveTouch(_ sender: UIBarButtonItem) {
		if checkValidity() {
			saveValues()
			PomodoroTimer.shared.temporarySoundIndex = nil
			PomodoroTimer.shared.stopTimer()
			navigationController?.popViewController(animated: true)
		} else {
			presentAlert()
		}
	}
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let alertSoundVC = segue.destination as? AlertSoundViewController else { return }
        alertSoundVC.delegate = self
    }
}

extension SettingsViewController: AlertSoundViewControllerDelegate {
    func setAlertSoundLabel() {
        guard let idx = PomodoroTimer.shared.temporarySoundIndex else { return }
        alertSoundLabel.text = soundOP.formatSound(sound: idx)
    }
    
    func playSound() {
        guard let idx = PomodoroTimer.shared.temporarySoundIndex else { return }
        let url = soundOP.getSoundURL(sound: idx)
        audioPlayer = try? AVAudioPlayer(contentsOf: url)
        audioPlayer?.play()
    }
}
