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
		soundsForDisplay = prepareSoundsForDisplay(sounds: getSounds())
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
	
	func getSounds() -> [String] {
		let fm = FileManager.default
		let path = Bundle.main.resourcePath!
		var sounds = [String]()
		do {
			let items = try fm.contentsOfDirectory(atPath: path)
			for i in items {
				if i.suffix(4) == ".mp3" {
					sounds.append(i)
				}
			}
		} catch {
			print(error)
		}
		return sounds
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
}
