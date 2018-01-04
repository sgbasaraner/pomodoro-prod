//
//  Globals.swift
//  swiftPomodoro
//
//  Created by Sarp Guney on 30.12.2017.
//  Copyright © 2017 Sarp Guney. All rights reserved.
//

import Foundation
import UserNotifications

var secondsLeft = 0
var timer = Timer()
var timerRunning = false

let notificationCenter = UNUserNotificationCenter.current()

func removeAllNotifications() {
	notificationCenter.removeAllPendingNotificationRequests()
}

func stopTimer() {
	removeAllNotifications()
	if timerRunning {
		timer.invalidate()
		timerRunning = false
	}
}
