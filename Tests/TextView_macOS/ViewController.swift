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

        private var mCursorTimer: Timer? = nil

        deinit {
                stopTimer()
        }

        private func stopTimer() {
                if let cursortimer = mCursorTimer {
                        cursortimer.invalidate()
                }
        }

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

                self.execute(commands: [
                        .setCursorVisible(true),
                        .blinkCursor(true)
                ])

                let timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true) { timer in
                        DispatchQueue.main.async {
                                self.blinkCursor()
                        }
                }
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

        private var blink: Bool = false

        private func blinkCursor() {
                self.execute(commands: [.blinkCursor(self.blink)])
                self.blink = !self.blink
        }

        override var representedObject: Any? {
                didSet {
                // Update the view, if already loaded.
                }
        }


}

