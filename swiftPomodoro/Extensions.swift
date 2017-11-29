//
//  Extensions.swift
//  swiftPomodoro
//
//  Created by Sarp Guney on 24.11.2017.
//  Copyright © 2017 Sarp Guney. All rights reserved.
//

import Foundation

extension Int {
    func timerString() -> String {
        let minutes = self / 60 % 60
        let seconds = self % 60
        return String(format:"%02i:%02i", minutes, seconds)
    }
}

extension String {
	func titlecased() -> String {
		if self.count <= 1 {
			return self.uppercased()
		}
		
		let regex = try! NSRegularExpression(pattern: "(?=\\S)[A-Z]", options: [])
		let range = NSMakeRange(1, self.count - 1)
		var titlecased = regex.stringByReplacingMatches(in: self, range: range, withTemplate: " $0")
		
		for i in titlecased.indices {
			if i == titlecased.startIndex || titlecased[titlecased.index(before: i)] == " " {
				titlecased.replaceSubrange(i...i, with: String(titlecased[i]).uppercased())
			}
		}
		return titlecased
	}
}
