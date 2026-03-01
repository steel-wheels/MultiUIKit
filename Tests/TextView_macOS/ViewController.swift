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

                let res0 = cursorTest(textColor: textcol, backgroundColor: backcol)
                let res1 = keyCodesTest()

                if res0 && res1 {
                        NSLog("SUMMARY: OK")
                } else {
                        NSLog("SUMMARY: Error")
                }
        }

        private func cursorTest(textColor textcol: MIColor, backgroundColor backcol: MIColor) -> Bool {
                self.execute(commands: [
                        .setTextColor(textcol),
                        .setBackgroundColor(backcol),
                ])

                var result = true

                self.execute(commands: [
                        .insertText("ab")
                ])
                result = check(string: "ab ") && result

                self.execute(commands: [
                        .moveCursorBackward(1),
                        .moveCursorForward(2)
                ])
                result = check(string: "ab ") && result

                self.execute(commands: [
                        .insertText("de"),
                        .insertText("c")
                ])
                result = check(string: "abcde ") && result

                self.execute(commands: [
                        .removeForward(1)
                ])
                result = check(string: "abde ") && result

                self.execute(commands: [
                        .removeBackward(1)
                ])
                result = check(string: "ade ") && result

                self.execute(commands: [
                        .setTextColor(MIColor.red),
                        .setBackgroundColor(MIColor.blue),
                        .insertText("BC")
                ])
                result = check(string: "aBCde ") && result

                self.execute(commands: [
                        .setCursorVisible(true),
                        .blinkCursor(true)
                ])

                mCursorTimer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true) { timer in
                        DispatchQueue.main.async {
                                self.blinkCursor()
                        }
                }

                NSLog("CursorTest: \(result ? "OK" : "Error")")
                return result
        }

        private func execute(commands cmds: Array<MITextEditCommand>) {
                mTextView.execute(commands: cmds)
                //let storage = mTextView.storage
                //let str = mTextView.storage.context.string
                //NSLog("storage: length=\(storage.validLength) pos=\(storage.cursorPosition) str=\"\(str)\"")
        }

        private func check(string exp: String) -> Bool {
                let str = mTextView.storage.context.string
                if str == exp {
                        return true
                } else {
                        NSLog("Unexpected content \"\(str)\" expected \"\(exp)\"")
                        return false
                }
        }

        private func blinkCursor() {
                let cursor = mTextView.cursor
                self.execute(commands: [.blinkCursor(!cursor.blink)])
        }

        private func keyCodesTest() -> Bool {
                let keycodes: Array<MIKeyCode> = [
                        .string("Hello"),
                        .backspaceCode,
                        .carriageReturn,
                        .deleteCode,
                        .downArrow,
                        .enterCode,
                        .functionCode(10),
                        .formFeed,
                        .help,
                        .home,
                        .insert,
                        .leftArrow,
                        .menu,
                        .newline,
                        .pageDown,
                        .pageUp,
                        .rightArrow,
                        .tab,
                        .upArrow
                ]
                var result = true
                for code in keycodes {
                        result = result && keyCodeTest(keyCode: code)
                }
                NSLog("KeyCodeTest: \(result ? "OK" : "Error")")
                return result
        }

        private func keyCodeTest(keyCode code: MIKeyCode) -> Bool {
                var result = true
                let enc  = code.encode()
                let desc = code.description
                //NSLog("description: \"\(code.description)\", enc: \(enc)")
                switch MIKeyCode.decode(string: enc) {
                case .success(let newcodes):
                        if newcodes.count == 1 {
                                let newdesc = newcodes[0].description
                                if desc != newdesc {
                                        NSLog("[Error] Unexpected decode result: \(desc) != \(newdesc)")
                                        result = false
                                }
                        } else {
                                NSLog("[Error] Unexpected number")
                                result = false
                        }
                case .failure(let err):
                        NSLog("[Error] \(MIError.toString(error: err))")
                        result = false
                }
                return result
        }

        override var representedObject: Any? {
                didSet {
                // Update the view, if already loaded.
                }
        }


}

