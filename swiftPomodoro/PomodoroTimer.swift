//
//  PomodoroTimer.swift
//  swiftPomodoro
//
//  Created by Sarp Guney on 10.02.2019.
//  Copyright © 2019 Sarp Guney. All rights reserved.
//

import Foundation

class PomodoroTimer {
	private init() { }
	
	static let shared = PomodoroTimer()
	var secondsLeft = 0
	var timer = Timer()
	var timerRunning = false
	var temporarySoundIndex: Int? = nil
	
	func stopTimer() {
		NotificationsOperator.removeAllPendingNotifications()
		if timerRunning {
			timer.invalidate()
			timerRunning = false
		}
	}
}
