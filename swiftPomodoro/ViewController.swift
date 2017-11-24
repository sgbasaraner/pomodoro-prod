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
    
    let pomodoroSeconds = 1500
    let shortBreakSeconds = 300
    let longBreakSeconds = 600
    
    override func viewDidLoad() {
        super.viewDidLoad()
        seconds = pomodoroSeconds
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
            timerLabel.text = "\(seconds / 60):\(seconds % 60)"
            // TODO: format the timerLabel string
        }
    }
    
    @IBAction func pomodoroTouch(_ sender: UIButton) {
        runTimer()
        seconds = pomodoroSeconds
    }
    
    @IBAction func shortBreakTouch(_ sender: UIButton) {
        runTimer()
        seconds = shortBreakSeconds
    }
    
    @IBAction func longBreakTouch(_ sender: UIButton) {
        runTimer()
        seconds = longBreakSeconds
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
    }
}

