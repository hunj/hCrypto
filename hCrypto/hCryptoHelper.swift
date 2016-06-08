//
//  hCryptoHelper.swift
//  hCrypto
//
//  Created by Hun Jae Lee on 6/7/16.
//  Copyright © 2016 Hun Jae Lee. All rights reserved.
//

import Foundation
import Cocoa

/// String & Character extension.
/// http://stackoverflow.com/a/29835826/4927106
extension String {
	var asciiValue: UInt32 {
		guard let first = characters.first where characters.count == 1 else  { return 0 }
		return first.unicodeScalarsValue
	}
	func asciiValueAt(pos pos: Int) -> UInt32 {
		guard characters.count > 0 && pos < characters.count else  { return 0 }
		return Array(characters)[pos].unicodeScalarsValue
	}
}

extension Character {
	var unicodeScalarsValue: UInt32 {
		return String(self).unicodeScalars.first!.value
	}
}

/// Shows a simple popup alert message with [OK] button and given message.
func showAlert(message: String) {
	let alertView = NSAlert()
	alertView.messageText = "Error"
	alertView.informativeText = message
	alertView.addButtonWithTitle("OK")
	alertView.alertStyle = NSAlertStyle.WarningAlertStyle
	alertView.runModal()
}