/*
 * @file MITextEditCommand.swift
 * @description Define MITextEditCommand class
 * @par Copyright
 *   Copyright (C) 2025 Steel Wheels Project
 */

#if os(OSX)
import  AppKit
#else   // os(OSX)
import  UIKit
#endif  // os(OSX)

public enum MITextEditCommand
{
        case insertText(String)
        case moveCursorToHome
        case moveCursorBackward(Int)
        case moveCursorForward(Int)
        case removeForward(Int)
        case removeBackward(Int)
        case removeAll
        case setFont(MIFont)
        case setTextColor(MIColor)
        case setBackgroundColor(MIColor)
        case setCursorVisible(Bool)
        case blinkCursor(Bool)
}

extension MITextView
{
        public func execute(commands cmds: Array<MITextEditCommand>) {
                if let core: MITextViewCore = super.coreView() {
                        core.execute(commands: cmds)
                } else {
                        NSLog("[Error] No core view")
                }
        }
}

extension MITextViewCore
{
        public func execute(commands cmds: Array<MITextEditCommand>) {
                let strg = self.storage
                strg.beginEditing()
                for cmd in cmds {
                        execute(command: cmd, storage: strg)
                }
                strg.endEditing()
        }

        private func execute(command cmd: MITextEditCommand, storage strg: MITextStorage) {
                switch cmd {
                case .insertText(let str):
                        strg.insert(string: str)
                case .moveCursorToHome:
                        strg.moveCursorToHome()
                case .moveCursorForward(let offset):
                        strg.moveCursorForward(offset: offset)
                case .moveCursorBackward(let offset):
                        strg.moveCursorBackward(offset: offset)
                case .removeForward(let len):
                        strg.deleteForward(length: len)
                case .removeBackward(let len):
                        strg.deleteBackward(length: len)
                case .removeAll:
                        strg.deleteAll()
                case .setFont(let font):
                        strg.setFont(font)
                case .setTextColor(let col):
                        strg.setTextColor(color: col)
                case .setBackgroundColor(let col):
                        strg.setBackgoundColor(color: col)
                case .setCursorVisible(let dovisible):
                        setCusorVisible(dovisible: dovisible, storage: strg)
                case .blinkCursor(let doon):
                        blinkCursor(blink: doon, storage: strg)
                }
        }

        private func setCusorVisible(dovisible: Bool, storage strg: MITextStorage) {
                guard self.cursor.visible != dovisible else {
                        return
                }
                if dovisible {
                        /* visible: off -> on */
                        self.cursor.visible = true
                } else {
                        /* visible: on -> off */
                        if self.cursor.blink {
                                blinkCursor(blink: false, storage: strg)
                        }
                        self.cursor.visible = false
                }
        }

        private func blinkCursor(blink doblink: Bool, storage strg: MITextStorage) {
                guard self.cursor.visible else {
                        return
                }
                guard self.cursor.blink != doblink else {
                        return
                }
                if doblink {
                        /* blink: off -> on */
                        self.cursor.normalAttribute = strg.currentAttribute()
                        strg.set(attribute: self.cursor.reversedAttribute, length: 1)
                } else {
                        /* blink: on -> off */
                        strg.set(attribute: self.cursor.normalAttribute, length: 1)
                }
        }
}
