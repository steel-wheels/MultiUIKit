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

                mTextView.textBackgroundColor = MIColor.blue

                let storage = mTextView.textStorage
                let commands: Array<MITextStorage.Command> = [
                        .font(MIFont.monospacedSystemFont(ofSize: MIFont.systemFontSize, weight: .regular)),
                        .textColor(MIColor.yellow),
                        .backgroundColor(MIColor.blue),
                        .append("Hello, world")
                ]
                storage.update(commands: commands)
                NSLog("storage = \(storage.string)")
                NSLog("screen_size = \(storage.screenWidth) x \(storage.screenHeight)")
        }

        override var representedObject: Any? {
                didSet {
                // Update the view, if already loaded.
                }
        }


}

