//
//  Sound.swift
//  swiftPomodoro
//
//  Created by Sarp Guney on 29.11.2017.
//  Copyright © 2017 Sarp Guney. All rights reserved.
//

import Foundation

var temporarySound: Int? = nil

struct SoundOperator {
	
	let fm = FileManager.default
	let path = Bundle.main.resourcePath!
	let def = UserDefaults()
	
	func getSounds() -> [String] {
		var sounds = [String]()
		do {
			let items = try fm.contentsOfDirectory(atPath: path)
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
	
	func getCurrentSoundFormatted() -> String {
		let sounds = getSounds()
		var currentSound = sounds[def.integer(forKey: "alertSound")]
		currentSound.removeLast(4)
		currentSound = currentSound.replacingOccurrences(of: "-", with: " ", options: .literal, range: nil)
		currentSound = currentSound.titlecased()
		return currentSound
	}
	
	func getCurrentSoundURL() -> URL {
		let sounds = getSounds()
		var currentSound = sounds[def.integer(forKey: "alertSound")]
		currentSound.removeLast(4)
		let path = Bundle.main.path(forResource: currentSound, ofType: "mp3")!
		return URL(fileURLWithPath: path)
	}
	
	func formatSound(sound: Int) -> String {
		let sounds = getSounds()
		var currentSound = sounds[sound]
		currentSound.removeLast(4)
		currentSound = currentSound.replacingOccurrences(of: "-", with: " ", options: .literal, range: nil)
		currentSound = currentSound.titlecased()
		return currentSound
	}
	
	func getSoundURL(sound: Int) -> URL {
		let sounds = getSounds()
		var currentSound = sounds[sound]
		currentSound.removeLast(4)
		let path = Bundle.main.path(forResource: currentSound, ofType: "mp3")!
		return URL(fileURLWithPath: path)
	}
}
