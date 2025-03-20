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

                let fontsize = 20.0 // MIFont.systemFontSize
                let font: MIFont
                if let fnt = MIFont.terminalFont(size: fontsize) {
                        NSLog("use terminal font: \(fontsize)")
                        font = fnt
                } else {
                        NSLog("use default font: \(fontsize)")
                        font = MIFont.monospacedSystemFont(ofSize: fontsize, weight: .regular)
                }

                let storage = mTextView.textStorage
                let commands: Array<MITextStorage.Command> = [
                        .font(font),
                        .textColor(MIColor.yellow),
                        .backgroundColor(MIColor.blue),
                        .insert("Hello, world"),
                        .moveBackward(5),
                        .insert("every ")
                ]
                storage.execute(commands: commands)

                let fsize = storage.fontSize
                NSLog("fontsize = \(fsize.width) * \(fsize.height)")
        }

        override var representedObject: Any? {
                didSet {
                // Update the view, if already loaded.
                }
        }


}

