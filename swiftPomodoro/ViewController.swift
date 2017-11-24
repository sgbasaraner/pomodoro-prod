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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateTimer()
    }
    
    func runTimer() {
        timer = Timer.init(timeInterval: 1, target: self, selector: (#selector(updateTimer)), userInfo: nil, repeats: true)
        
        RunLoop.main.add(timer, forMode: RunLoopMode.commonModes)
    }
    
    @objc func updateTimer() {
        if seconds >= 1{
            seconds -= 1
        }
        timerLabel.text = "\(seconds / 60):\(seconds % 60)"
    }
    
    @IBAction func pomodoroTouch(_ sender: UIButton) {
        seconds = 25 * 60
        runTimer()
    }
    
    @IBAction func shortBreakTouch(_ sender: UIButton) {
    }
    
    @IBAction func longBreakTouch(_ sender: UIButton) {
    }
    
    @IBAction func startTouch(_ sender: UIButton) {
    }
    
    @IBAction func stopTouch(_ sender: UIButton) {
    }
    
    @IBAction func resetTouch(_ sender: UIButton) {
    }
}

