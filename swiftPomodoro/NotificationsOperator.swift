//
//  NotificationsOperator.swift
//  swiftPomodoro
//
//  Created by Sarp Guney on 31.03.2018.
//  Copyright © 2018 Sarp Guney. All rights reserved.
//

import Foundation
import UserNotifications

struct NotificationsOperator {
	static func removeAllNotifications() {
		UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
	}
	
	static func createNotification(for mode: TimerMode) {
		// remove all previous notifications
		NotificationsOperator.removeAllNotifications()
		
		// notification content
		let content = UNMutableNotificationContent()
		content.title = NSString.localizedUserNotificationString(forKey: "Hey!", arguments: nil)
		content.body = NSString.localizedUserNotificationString(forKey: "\(mode.name) is now over.", arguments: nil)
		content.sound = UNNotificationSound.default()
		content.badge = 1
		
		// trigger time
		let trigger = UNTimeIntervalNotificationTrigger(timeInterval: TimeInterval(mode.seconds), repeats: false)
		
		// create the request
		let request = UNNotificationRequest(identifier: "TimerNotification", content: content, trigger: trigger)
		
		UNUserNotificationCenter.current().add(request) { (error : Error?) in
			if let theError = error {
				print(theError.localizedDescription)
			}
		}
	}
}
