//
//  Sound.swift
//  swiftPomodoro
//
//  Created by Sarp Guney on 29.11.2017.
//  Copyright © 2017 Sarp Guney. All rights reserved.
//

import Foundation

fileprivate struct Constants {
    static let fm = FileManager.default
    static let path = Bundle.main.resourcePath!
    static let def = UserDefaults()
}

struct SoundOperator {
	
	static func getSounds() -> [String] {
		var sounds = [String]()
		do {
			let items = try Constants.fm.contentsOfDirectory(atPath: Constants.path)
			for i in items {
				if i.suffix(4) == ".mp3" {
					sounds.append(i)
				}
			}
		} catch {
			print(error)
		}
		return sounds
	}
	
	static func getCurrentSoundFormatted() -> String {
		let sounds = getSounds()
		var currentSound = sounds[Constants.def.integer(forKey: Keys.alertSoundIndex)]
		currentSound.removeLast(4)
		currentSound = currentSound.replacingOccurrences(of: "-", with: " ", options: .literal, range: nil)
		currentSound = currentSound.titlecased()
		return currentSound
	}
	
	static func getCurrentSoundURL() -> URL {
		let sounds = getSounds()
		var currentSound = sounds[Constants.def.integer(forKey: Keys.alertSoundIndex)]
		currentSound.removeLast(4)
		let path = Bundle.main.path(forResource: currentSound, ofType: "mp3")!
		return URL(fileURLWithPath: path)
	}
	
	static func formatSound(sound: Int) -> String {
		let sounds = getSounds()
		var currentSound = sounds[sound]
		currentSound.removeLast(4)
		currentSound = currentSound.replacingOccurrences(of: "-", with: " ", options: .literal, range: nil)
		currentSound = currentSound.titlecased()
		return currentSound
	}
	
	static func getSoundURL(sound: Int) -> URL {
		let sounds = getSounds()
		var currentSound = sounds[sound]
		currentSound.removeLast(4)
		let path = Bundle.main.path(forResource: currentSound, ofType: "mp3")!
		return URL(fileURLWithPath: path)
	}
}
