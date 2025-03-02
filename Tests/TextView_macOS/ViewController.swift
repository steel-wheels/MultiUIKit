//
//  ViewController.swift
//  TextView_macOS
//
//  Created by Tomoo Hamada on 2025/03/02.
//

import MultiUIKit
import Cocoa

class ViewController: NSViewController
{

        @IBOutlet weak var mTextView: MITextView!

        override func viewDidLoad() {
                super.viewDidLoad()

                // Do any additional setup after loading the view.
                mTextView.textBackgroundColor = NSColor.blue
                mTextView.textColor = NSColor.yellow

                let storage = mTextView.textStorage
                let commands: Array<MITextStorage.Command> = [
                        .textColor(NSColor.yellow),
                        .append("Hello, world")
                ]
                storage.update(commands: commands)
                NSLog("storage = \(storage.string)")
                mTextView.needsDisplay = true
        }

        override var representedObject: Any? {
                didSet {
                // Update the view, if already loaded.
                }
        }


}

