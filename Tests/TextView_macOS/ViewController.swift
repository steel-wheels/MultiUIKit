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

                let textcol = MIColor.green
                let backcol = MIColor.black
                mTextView.textColor       = textcol
                mTextView.backgroundColor = backcol

                self.execute(commands: [
                        .setTextColor(textcol),
                        .setBackgroundColor(backcol),
                ])

                self.execute(commands: [
                        .insertText("ab")
                ])
                check(string: "ab ")

                self.execute(commands: [
                        .moveCursorBackward(1),
                        .moveCursorForward(2)
                ])
                check(string: "ab ")

                self.execute(commands: [
                        .insertText("de"),
                        .insertText("c")
                ])
                check(string: "abcde ")

                self.execute(commands: [
                        .removeForward(1)
                ])
                check(string: "abde ")

                self.execute(commands: [
                        .removeBackward(1)
                ])
                check(string: "ade ")

                self.execute(commands: [
                        .setTextColor(MIColor.red),
                        .setBackgroundColor(MIColor.blue),
                        .insertText("BC")
                ])
                check(string: "aBCde ")

                /*


                let fontsize = 20.0 // MIFont.systemFontSize
                let font: MIFont
                if let fnt = MIFont.terminalFont(size: fontsize) {
                        NSLog("use terminal font: \(fontsize)")
                        font = fnt
                } else {
                        NSLog("use default font: \(fontsize)")
                        font = MIFont.monospacedSystemFont(ofSize: fontsize, weight: .regular)
                }

                let fsize = storage.fontSize
                NSLog("fontsize = \(fsize.width) * \(fsize.height)")
                 */
        }

        private func execute(commands cmds: Array<MITextEditCommand>) {
                mTextView.execute(commands: cmds)
                let storage = mTextView.storage
                let str = mTextView.storage.context.string
                NSLog("storage: length=\(storage.validLength) pos=\(storage.cursorPosition) str=\"\(str)\"")
        }

        private func check(string exp: String) {
                let str = mTextView.storage.context.string
                if str != exp {
                        NSLog("Unexpected content \"\(str)\" expected \"\(exp)\"")
                }
        }


        override var representedObject: Any? {
                didSet {
                // Update the view, if already loaded.
                }
        }


}

