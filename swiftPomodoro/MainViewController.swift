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
	
	// IBOutlet variables
	
    @IBOutlet weak private var timerLabel: UILabel!
	@IBOutlet weak private var startButton: UIButton!
	@IBOutlet weak private var stopButton: UIButton!
	@IBOutlet weak private var resetButton: UIButton!
	@IBOutlet weak private var pomodoroButton: TimerModeButton!
	@IBOutlet weak private var shortBreakButton: TimerModeButton!
	@IBOutlet weak private var longBreakButton: TimerModeButton!
	
	// Class variables
	
	private var timerModeButtons = [TimerModeButton]()
	private var audioPlayer: AVAudioPlayer? = nil
	private var timerModes = [TimerMode]()
	private var currentMode = TimerMode.allModes[0] // currentMode is Pomodoro by default
	private let soundOP = SoundOperator()
	
	// Lifecycle methods
	
    override func viewDidLoad() {
        super.viewDidLoad()
		setupButtons()
		timerModes = TimerMode.allModes
        PomodoroTimer.shared.secondsLeft = currentMode.seconds
		timerLabel.text = PomodoroTimer.shared.secondsLeft.timerString()
		timerModeButtons = [pomodoroButton, shortBreakButton, longBreakButton]
		highlight(pomodoroButton)
		NotificationsOperator.requestAuth()
    }
	
	// Private implementation
	
    private func runTimer() {
        if !PomodoroTimer.shared.timerRunning {
			UIApplication.shared.isIdleTimerDisabled = true
            PomodoroTimer.shared.timer = Timer.scheduledTimer(timeInterval: 1,
                                         target: self,
                                         selector: (#selector(self.updateTimer)),
                                         userInfo: nil,
                                         repeats: true)
            PomodoroTimer.shared.timerRunning = true
        }
    }
    
    @objc private func updateTimer() {
        if PomodoroTimer.shared.secondsLeft < 1 {
			let def = UserDefaults()
            PomodoroTimer.shared.timer.invalidate()
			PomodoroTimer.shared.timerRunning = false
			playSound()
			if def.bool(forKey: Keys.vibrationSwitch) {
				vibrate()
			}
			presentAlert()
			UIApplication.shared.isIdleTimerDisabled = false
        } else {
            PomodoroTimer.shared.secondsLeft -= 1
            timerLabel.text = PomodoroTimer.shared.secondsLeft.timerString()
        }
    }
    
	@IBAction private func pomodoroTouch(_ sender: TimerModeButton) {
        runTimer()
        currentMode = timerModes[0]
        PomodoroTimer.shared.secondsLeft = currentMode.seconds
		NotificationsOperator.createNotification(for: currentMode)
		highlight(sender)
    }
    
    @IBAction private func shortBreakTouch(_ sender: TimerModeButton) {
        runTimer()
        currentMode = timerModes[1]
        PomodoroTimer.shared.secondsLeft = currentMode.seconds
		NotificationsOperator.createNotification(for: currentMode)
		highlight(sender)
    }
    
    @IBAction private func longBreakTouch(_ sender: TimerModeButton) {
        runTimer()
        currentMode = timerModes[2]
        PomodoroTimer.shared.secondsLeft = currentMode.seconds
		NotificationsOperator.createNotification(for: currentMode)
		highlight(sender)
    }
    
    @IBAction private func startTouch(_ sender: UIButton) {
		if PomodoroTimer.shared.secondsLeft >= 1 {
			runTimer()
			NotificationsOperator.createNotification(for: currentMode)
		}
    }
    
    @IBAction private func stopTouch(_ sender: UIButton) {
        PomodoroTimer.shared.stopTimer()
    }
    
    @IBAction private func resetTouch(_ sender: UIButton) {
		PomodoroTimer.shared.stopTimer()
        PomodoroTimer.shared.secondsLeft = currentMode.seconds
        timerLabel.text = PomodoroTimer.shared.secondsLeft.timerString()
    }
	
	private func presentAlert() {
		let alert = UIAlertController(title: "Hey!", message: "\(currentMode.name) is now over.", preferredStyle: UIAlertControllerStyle.alert)
		let ok = UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil)
		alert.addAction(ok)
		present(alert, animated: true, completion: nil)
		timerLabel.text = PomodoroTimer.shared.secondsLeft.timerString()
	}
	
	private func vibrate() {
		// vibrates twice with one second interval
		AudioServicesPlaySystemSoundWithCompletion(kSystemSoundID_Vibrate, nil)
		DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1), execute: {
			AudioServicesPlaySystemSoundWithCompletion(kSystemSoundID_Vibrate, nil)
		})
	}
	
	private func playSound() {
		let url = SoundOperator.getCurrentSoundURL()
		audioPlayer = try! AVAudioPlayer(contentsOf: url)
		audioPlayer!.play()
	}
	
	private func highlight(_ button: TimerModeButton) {
		timerModeButtons.forEach { $0.chosen = $0 == button }
	}
	
	private func setupButtons() {
		startButton.backgroundColor = UIColor(red:0.36, green:0.64, blue:0.14, alpha:1.0)
		startButton.setTitleColor(UIColor.white, for: .normal)
		stopButton.backgroundColor = UIColor(red:0.78, green:0.06, blue:0.07, alpha:1.0)
		stopButton.setTitleColor(UIColor.white, for: .normal)
		resetButton.backgroundColor = UIColor(red:0.91, green:0.91, blue:0.91, alpha:1.0)
		resetButton.setTitleColor(UIColor.black, for: .normal)
	}
}

