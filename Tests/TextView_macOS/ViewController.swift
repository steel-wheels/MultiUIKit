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

                self.execute(commands: [
                        .insertText("ab")
                ])

                self.execute(commands: [
                        .moveCursorBackward(1),
                        .moveCursorForward(2)
                ])

                self.execute(commands: [
                        .insertText("de"),
                        .insertText("c")
                ])

                /*
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



                        .font(font),
                        .textColor(MIColor.yellow),
                        .backgroundColor(MIColor.blue),
                        .insert("Hello, world"),
                        .moveBackward(5),
                        .insert("every ")
                ]


                let fsize = storage.fontSize
                NSLog("fontsize = \(fsize.width) * \(fsize.height)")
                 */
        }

        private func execute(commands cmds: Array<MITextEditCommand>) {
                mTextView.execute(commands: cmds)
                let storage = mTextView.storage
                NSLog("storage: length=\(storage.validLength) pos=\(storage.cursorPosition)")
        }


        override var representedObject: Any? {
                didSet {
                // Update the view, if already loaded.
                }
        }


}

