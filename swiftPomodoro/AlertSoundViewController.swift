//
//  AlertSoundViewController.swift
//  swiftPomodoro
//
//  Created by Sarp Guney on 29.11.2017.
//  Copyright © 2017 Sarp Guney. All rights reserved.
//

import UIKit

class AlertSoundViewController: UITableViewController {

	// Class variables
	
	private var soundsForDisplay = [String]()
	private var settingsViewController: IsSettings?
	private let soundOP = SoundOperator()
	
	// Lifecycle methods
	
    override func viewDidLoad() {
        super.viewDidLoad()
		let sounds = soundOP.getSounds()
		soundsForDisplay = prepareSoundsForDisplay(sounds: sounds)
		findSettingsViewController()
    }
	
	// Table view implementation
	
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return soundsForDisplay.count
	}
	
	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
		cell.textLabel?.text = soundsForDisplay[indexPath.row]
		return cell
	}
	
	override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		PomodoroTimer.shared.temporarySoundIndex = indexPath.row
		settingsViewController?.setAlertSoundLabel()
		settingsViewController?.playSound()
		_ = navigationController?.popViewController(animated: true)
	}
	
	func prepareSoundsForDisplay(sounds: [String]) -> [String]{
		var result = [String]()
		for s in sounds {
			var a = s
			a.removeLast(4)
			a = a.replacingOccurrences(of: "-", with: " ", options: .literal, range: nil)
			a = a.titlecased()
			result.append(a)
		}
		return result
	}
	
	func findSettingsViewController() {
		// finds SettingsViewController to change its alertSoundLabel
		// with the name of the sound selected in this ViewController
		for vc in (self.navigationController?.viewControllers)! {
			if let controller = vc as? IsSettings {
				settingsViewController = controller
			}
		}
	}
}
