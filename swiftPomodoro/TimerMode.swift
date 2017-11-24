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

let pomodoro = TimerMode(name: "Pomodoro", seconds: 1500)
let shortBreak = TimerMode(name: "Short break", seconds: 300)
let longBreak = TimerMode(name: "Long break", seconds: 600)
