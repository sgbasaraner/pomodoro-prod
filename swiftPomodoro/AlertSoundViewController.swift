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
	private let soundOP = SoundOperator()
    
    weak var delegate: AlertSoundViewControllerDelegate?
	
	// Lifecycle methods
	
    override func viewDidLoad() {
        super.viewDidLoad()
		let sounds = soundOP.getSounds()
		soundsForDisplay = prepareSoundsForDisplay(sounds: sounds)
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
		delegate?.setAlertSoundLabel()
		delegate?.playSound()
		navigationController?.popViewController(animated: true)
	}
	
	func prepareSoundsForDisplay(sounds: [String]) -> [String]{
        let result = sounds.map { (s) -> String in
            var a = s
            a.removeLast(4)
            a = a.replacingOccurrences(of: "-", with: " ", options: .literal, range: nil)
            a = a.titlecased()
            return a
        }
		return result
	}
}

protocol AlertSoundViewControllerDelegate: class {
    func setAlertSoundLabel()
    func playSound()
}
