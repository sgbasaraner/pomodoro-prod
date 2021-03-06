//
//  TimerMode.swift
//  swiftPomodoro
//
//  Created by Sarp Guney on 24.11.2017.
//  Copyright © 2017 Sarp Guney. All rights reserved.
//

import Foundation

struct TimerMode {
    let name: String
    let seconds: Int
	
	static var allModes: [TimerMode] {
		// generates timer modes, from the UserDefaults if they're present
		// if not, give default pomodoro values
		let def = UserDefaults()
		var defs = [1500, 300, 600]
		let prefs = [def.integer(forKey: Keys.pomodoroSec), def.integer(forKey: Keys.sbSec), def.integer(forKey: Keys.lbSec)]
        for (i, pref) in prefs.enumerated() {
            // UserDefaults integers return 0 if there are no values, hence this check:
            if pref != 0 {
                defs[i] = pref
            }
        }
		let result = [TimerMode(name: "Domates", seconds: defs[0]), TimerMode(name: "Short break", seconds: defs[1]), TimerMode(name: "Long break", seconds: defs[2])]
		return result
	}
}
