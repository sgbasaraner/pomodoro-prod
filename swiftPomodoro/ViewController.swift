//
//  ViewController.swift
//  swiftPomodoro
//
//  Created by Sarp Guney on 24.11.2017.
//  Copyright © 2017 Sarp Guney. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var timerLabel: UILabel!
    
    var seconds = 0
    var timer = Timer()
    var timerRunning = false
    
    var currentMode = pomodoro
    
    override func viewDidLoad() {
        super.viewDidLoad()
        seconds = currentMode.seconds
    }
    
    func runTimer() {
        if !timerRunning {
            timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: (#selector(self.updateTimer)), userInfo: nil, repeats: true)
            timerRunning = true
        }
    }
    
    @objc func updateTimer() {
        if seconds < 1 {
            timer.invalidate()
            // TODO: alert the user
        } else {
            seconds -= 1
            timerLabel.text = formatTimerString(seconds: seconds)
        }
    }
    
    @IBAction func pomodoroTouch(_ sender: UIButton) {
        runTimer()
        currentMode = pomodoro
        seconds = currentMode.seconds
    }
    
    @IBAction func shortBreakTouch(_ sender: UIButton) {
        runTimer()
        currentMode = shortBreak
        seconds = currentMode.seconds
    }
    
    @IBAction func longBreakTouch(_ sender: UIButton) {
        runTimer()
        currentMode = longBreak
        seconds = currentMode.seconds
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
        timerLabel.text = formatTimerString(seconds: seconds)
    }
    
    func formatTimerString(seconds: Int) -> String {
        let minutes = seconds / 60 % 60
        let seconds = seconds % 60
        return String(format:"%02i:%02i", minutes, seconds)
    }
}

