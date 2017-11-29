//
//  AlertSoundViewController.swift
//  swiftPomodoro
//
//  Created by Sarp Guney on 29.11.2017.
//  Copyright © 2017 Sarp Guney. All rights reserved.
//

import UIKit

class AlertSoundViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
	
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
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
}
