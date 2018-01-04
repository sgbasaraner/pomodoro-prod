//
//  MainViewController.swift
//  swiftPomodoro
//
//  Created by Sarp Guney on 24.11.2017.
//  Copyright © 2017 Sarp Guney. All rights reserved.
//

import UIKit
import AudioToolbox
import AVFoundation
import UserNotifications

class MainViewController: UIViewController {
    
    @IBOutlet weak var timerLabel: UILabel!
	@IBOutlet weak var startButton: UIButton!
	@IBOutlet weak var stopButton: UIButton!
	@IBOutlet weak var resetButton: UIButton!
	@IBOutlet weak var pomodoroButton: TimerModeButton!
	@IBOutlet weak var shortBreakButton: TimerModeButton!
	@IBOutlet weak var longBreakButton: TimerModeButton!
	var timerModeButtons = [TimerModeButton]()
	
	var audioPlayer: AVAudioPlayer? = nil
	
	var timerModes = [TimerMode]()
	var currentMode = generateTimerModes()[0] // currentMode is Pomodoro by default
	
	let soundOP = SoundOperator()
    
    override func viewDidLoad() {
        super.viewDidLoad()
		setupButtons()
		timerModes = generateTimerModes()
        secondsLeft = currentMode.seconds
		timerLabel.text = secondsLeft.timerString()
		timerModeButtons = [pomodoroButton, shortBreakButton, longBreakButton]
		highlight(pomodoroButton)
		notificationCenter.requestAuthorization(options: [.alert, .sound, .badge], completionHandler: { didAllow, error in })
    }
    
    func runTimer() {
        if !timerRunning {
			UIApplication.shared.isIdleTimerDisabled = true
            timer = Timer.scheduledTimer(timeInterval: 1,
                                         target: self,
                                         selector: (#selector(self.updateTimer)),
                                         userInfo: nil,
                                         repeats: true)
            timerRunning = true
        }
    }
    
    @objc func updateTimer() {
        if secondsLeft < 1 {
			let def = UserDefaults()
            timer.invalidate()
			timerRunning = false
			playSound()
			if def.bool(forKey: "vibrationSwitch") {
				vibrate()
			}
			presentAlert()
			UIApplication.shared.isIdleTimerDisabled = false
        } else {
            secondsLeft -= 1
            timerLabel.text = secondsLeft.timerString()
        }
    }
    
    @IBAction func pomodoroTouch(_ sender: TimerModeButton) {
        runTimer()
        currentMode = timerModes[0]
        secondsLeft = currentMode.seconds
		createNotification(for: currentMode)
		highlight(sender)
    }
    
    @IBAction func shortBreakTouch(_ sender: TimerModeButton) {
        runTimer()
        currentMode = timerModes[1]
        secondsLeft = currentMode.seconds
		createNotification(for: currentMode)
		highlight(sender)
    }
    
    @IBAction func longBreakTouch(_ sender: TimerModeButton) {
        runTimer()
        currentMode = timerModes[2]
        secondsLeft = currentMode.seconds
		createNotification(for: currentMode)
		highlight(sender)
    }
    
    @IBAction func startTouch(_ sender: UIButton) {
		if secondsLeft >= 1 {
			runTimer()
			createNotification(for: currentMode)
		}
    }
    
    @IBAction func stopTouch(_ sender: UIButton) {
        stopTimer()
    }
    
    @IBAction func resetTouch(_ sender: UIButton) {
		stopTimer()
        secondsLeft = currentMode.seconds
        timerLabel.text = secondsLeft.timerString()
    }
	
	func presentAlert() {
		let alert = UIAlertController(title: "Hey!", message: "\(currentMode.name) is now over.", preferredStyle: UIAlertControllerStyle.alert)
		let ok = UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil)
		alert.addAction(ok)
		present(alert, animated: true, completion: nil)
		timerLabel.text = secondsLeft.timerString()
	}
	
	func vibrate() {
		// vibrates twice with one second interval
		AudioServicesPlaySystemSoundWithCompletion(kSystemSoundID_Vibrate, nil)
		DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1), execute: {
			AudioServicesPlaySystemSoundWithCompletion(kSystemSoundID_Vibrate, nil)
		})
	}
	
	func playSound() {
		let url = soundOP.getCurrentSoundURL()
		audioPlayer = try! AVAudioPlayer(contentsOf: url)
		audioPlayer!.play()
	}
	
	func highlight(_ button: TimerModeButton) {
		for b in timerModeButtons {
			if b == button {
				b.chosen = true
			} else {
				b.chosen = false
			}
		}
	}
	
	func setupButtons() {
		startButton.backgroundColor = UIColor(red:0.36, green:0.64, blue:0.14, alpha:1.0)
		startButton.setTitleColor(UIColor.white, for: .normal)
		stopButton.backgroundColor = UIColor(red:0.78, green:0.06, blue:0.07, alpha:1.0)
		stopButton.setTitleColor(UIColor.white, for: .normal)
		resetButton.backgroundColor = UIColor(red:0.91, green:0.91, blue:0.91, alpha:1.0)
		resetButton.setTitleColor(UIColor.black, for: .normal)
	}
	
	func createNotification(for mode: TimerMode) {
		// remove all previous notifications
		removeAllNotifications()
		
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
		
		notificationCenter.add(request) { (error : Error?) in
			if let theError = error {
				print(theError.localizedDescription)
			}
		}
	}
}

