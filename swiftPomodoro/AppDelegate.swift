//
//  AppDelegate.swift
//  swiftPomodoro
//
//  Created by Sarp Guney on 24.11.2017.
//  Copyright © 2017 Sarp Guney. All rights reserved.
//

import UIKit
import UserNotifications

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func applicationDidEnterBackground(_ application: UIApplication) {
		saveTimer()
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        NotificationsOperator.removeAllNotifications()
		resumeTimer()
    }

    private func resumeTimer() {
        let def = UserDefaults()
        let timeEnterBackground: Date = def.object(forKey: Keys.enterBackground) as! Date
        let timeSpentInBackground = Date().timeIntervalSince1970 - timeEnterBackground.timeIntervalSince1970
        if PomodoroTimer.shared.secondsLeft - Int(timeSpentInBackground) > 0 {
            PomodoroTimer.shared.secondsLeft -= Int(timeSpentInBackground)
        } else {
            PomodoroTimer.shared.secondsLeft = 0
        }
    }
    
    private func saveTimer() {
        let def = UserDefaults()
        def.set(Date(), forKey: Keys.enterBackground)
    }
}

