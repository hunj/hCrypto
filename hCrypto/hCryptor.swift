//
//  hCryptor.swift
//  hCrypto
//
//  Created by Hun Jae Lee on 6/7/16.
//  Copyright © 2016 Hun Jae Lee. All rights reserved.
//

import Foundation

class hCryptor {
	var key = ""
	var message = ""
	
	init() {
		key = generateKey()
	}
	
	init(key: String) {
		self.key = key
	}
	
	init(message: String) {
		key = generateKey()
		self.message = message
	}
	
	
	// MARK: Public functions
	
	/**
	Encrypts the given text.
	- Parameter text: the `String` to encrypt
	- Returns: `(Ciphertext, Key)` tuple where `Ciphertext` is the encrypted text, and `Key` is the key to be used to decrypt later.
	*/
	func encrypt(text: String) -> (String, String) {
		var encrypted = String()
		
		let longKey = matchLengthOfKeyToText(text, key: self.key)
		let keyAscii = asciiValueArrayOf(longKey)
		let textAscii = asciiValueArrayOf(text)
		
		for i in 0 ..< textAscii.count {
			encrypted += String( UnicodeScalar(Int(textAscii[i]) + Int(keyAscii[i])) )
		}
		
		return (encrypted, self.key)
	}
	
	/**
	Decrypts the given text with given key.
	- Parameters:
	- ciphertext: the text to decrypt
	- key: the key to this decyphering
	- Returns: the deciphered message.
	*/
	func decrypt(ciphertext: String, key: String) -> String {
		var result = ""
		
		let asciiText = asciiValueArrayOf(ciphertext)
		let longKey = matchLengthOfKeyToText(ciphertext, key: key)
		let keyAscii = asciiValueArrayOf(longKey)
		
		for i in 0 ..< asciiText.count {
			result += String( UnicodeScalar(Int(asciiText[i]) - Int(keyAscii[i])) )
		}
		
		return result
	}
	
	// MARK: Private functions
	
	/**
	returns a randomly generated key of 32 characters (String).
	Resource: http://github.com/Flinesoft/HandySwift
	*/
	private func generateKey() -> String {
		let allowedChars = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
		let allowedCharsCount = UInt32(allowedChars.characters.count)
		var randomString = ""
		for _ in (0..<32) {
			let randomNum = Int(arc4random_uniform(allowedCharsCount))
			let newCharacter = allowedChars[allowedChars.startIndex.advancedBy(randomNum)]
			randomString += String(newCharacter)
		}
		return randomString
	}
	
	/**
	Returns an array of ascii values of each characters in the given String.
	- Parameter text: the String to convert into ascii value array
	- Returns: the array of ascii values of each characters in the given String.
	*/
	private func asciiValueArrayOf(text: String) -> [UInt32] {
		var asciiText = [UInt32]()
		for i in 0 ..< text.characters.count {
			asciiText.append(text.asciiValueAt(pos: i))
		}
		return asciiText
	}
	
	/**
	matches the length of given `key` to the length of `text` by reiterating.
	- Parameters:
		- text: the text to compare
		- key: the key to resize up
	- Returns: the resized `key`
	*/
	private func matchLengthOfKeyToText(text: String, key: String) -> String {
		var encryptKey = key
		while encryptKey.characters.count < text.characters.count {
			encryptKey += key
		}
		return encryptKey
	}
}