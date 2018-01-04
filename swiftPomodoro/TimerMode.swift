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
}

func generateTimerModes() -> [TimerMode] {
	// generates timer modes, from the UserDefaults if they're present
	// if not, give default pomodoro values
	let def = UserDefaults()
	var defs = [1500, 300, 600]
	let prefs = [def.integer(forKey: "pomodoroSeconds"), def.integer(forKey: "shortBreakSeconds"), def.integer(forKey: "longBreakSeconds")]
	for i in 0..<3 {
		// UserDefaults integers return 0 if there are no values, hence this check:
		if prefs[i] != 0 {
			defs[i] = prefs[i]
		}
	}
	let result = [TimerMode(name: "Domates", seconds: defs[0]), TimerMode(name: "Short break", seconds: defs[1]), TimerMode(name: "Long break", seconds: defs[2])]
	return result
}
