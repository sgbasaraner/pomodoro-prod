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
}
