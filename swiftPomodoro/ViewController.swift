//
//  ViewController.swift
//  swiftPomodoro
//
//  Created by Sarp Guney on 24.11.2017.
//  Copyright © 2017 Sarp Guney. All rights reserved.
//

import UIKit
import AudioToolbox

class ViewController: UIViewController {
    
    @IBOutlet weak var timerLabel: UILabel!
	@IBOutlet weak var pomodoroButton: TimerModeButton!
	@IBOutlet weak var shortBreakButton: TimerModeButton!
	@IBOutlet weak var longBreakButton: TimerModeButton!
	var timerModeButtons = [TimerModeButton]()
	
    var seconds = 0
    var timer = Timer()
    var timerRunning = false
    
    var currentMode = pomodoro
    
    override func viewDidLoad() {
        super.viewDidLoad()
        seconds = currentMode.seconds
		timerModeButtons = [pomodoroButton, shortBreakButton, longBreakButton]
		highlight(pomodoroButton)
    }
    
    func runTimer() {
        if !timerRunning {
            timer = Timer.scheduledTimer(timeInterval: 1,
                                         target: self,
                                         selector: (#selector(self.updateTimer)),
                                         userInfo: nil,
                                         repeats: true)
            timerRunning = true
        }
    }
    
    @objc func updateTimer() {
        if seconds < 1 {
            timer.invalidate()
			timerRunning = false
			vibrate()
			presentAlert()
        } else {
            seconds -= 1
            timerLabel.text = seconds.timerString()
        }
    }
    
    @IBAction func pomodoroTouch(_ sender: TimerModeButton) {
        runTimer()
        currentMode = pomodoro
        seconds = currentMode.seconds
		highlight(sender)
    }
    
    @IBAction func shortBreakTouch(_ sender: TimerModeButton) {
        runTimer()
        currentMode = shortBreak
        seconds = currentMode.seconds
		highlight(sender)
    }
    
    @IBAction func longBreakTouch(_ sender: TimerModeButton) {
        runTimer()
        currentMode = longBreak
        seconds = currentMode.seconds
		highlight(sender)
    }
    
    @IBAction func startTouch(_ sender: UIButton) {
        runTimer()
    }
    
    @IBAction func stopTouch(_ sender: UIButton) {
        if timerRunning {
            timer.invalidate()
            timerRunning = false
        }
    }
    
    @IBAction func resetTouch(_ sender: UIButton) {
        seconds = currentMode.seconds
        timerLabel.text = seconds.timerString()
    }
	
	func presentAlert() {
		let alert = UIAlertController(title: "Hey!", message: "\(currentMode.name) completed.", preferredStyle: UIAlertControllerStyle.alert)
		let ok = UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil)
		alert.addAction(ok)
		present(alert, animated: true, completion: nil)
	}
	
	func vibrate() {
		let generator = UIImpactFeedbackGenerator(style: .heavy)
		generator.impactOccurred()
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
}

