//
//  DecryptViewController.swift
//  hCrypto
//
//  Created by Hun Jae Lee on 6/7/16.
//  Copyright © 2016 Hun Jae Lee. All rights reserved.
//

import Cocoa

class DecryptViewController: NSViewController {
	@IBOutlet var inputTextField: NSTextField!
	@IBOutlet var outputTextField: NSTextField!
	@IBOutlet var keyField: NSTextField!
	@IBOutlet var submitButton: NSButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
    }
	
	@IBAction func decryptButtonPressed(sender: NSButton) {
		if inputTextField.stringValue == "" || keyField.stringValue == "" {
			showAlert("Text and Key is required!")
		} else {
			let cryptor = hCryptor()
			let decryptedMessage = cryptor.decrypt(inputTextField.stringValue, key: keyField.stringValue)
			outputTextField.stringValue = decryptedMessage
		}
	}
	
}
