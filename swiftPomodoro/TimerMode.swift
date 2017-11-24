//
//  TimerMode.swift
//  swiftPomodoro
//
//  Created by Sarp Guney on 24.11.2017.
//  Copyright © 2017 Sarp Guney. All rights reserved.
//

import Foundation

struct TimerMode {
    let name: String
    let seconds: Int
}

let pomodoro = TimerMode(name: "pomodoro", seconds: 1500)
let shortBreak = TimerMode(name: "shortBreak", seconds: 300)
let longBreak = TimerMode(name: "longBreak", seconds: 600)
