//
//  AlertSoundViewController.swift
//  swiftPomodoro
//
//  Created by Sarp Guney on 29.11.2017.
//  Copyright © 2017 Sarp Guney. All rights reserved.
//

import UIKit

class AlertSoundViewController: UITableViewController {

	var soundsForDisplay = [String]()
	
    override func viewDidLoad() {
        super.viewDidLoad()
		let sounds = getSounds()
		soundsForDisplay = prepareSoundsForDisplay(sounds: sounds)
    }
	
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
		let def = UserDefaults()
		def.set(indexPath.row, forKey: "alertSound")
		goToTimer()
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
}
