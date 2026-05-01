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
        case insertNewline
        case insertTab
        case moveCursorToHome
        case moveCursorBackward(Int)
        case moveCursorForward(Int)
        case moveCursorUp(Int)
        case moveCursorDown(Int)
        case moveCursorToBeginningOfLine
        case moveCursorToEndOfLine
        case moveCursorToBeginingOfPreviousLine // line up
        case moveCursorToBeginingOfNextLine     // line down
        case moveCursorToPoint(Int, Int)        // row, column
        case requireCursorPosition
        case removeForward(Int)
        case removeBackward(Int)
        case removeAll
        case setFont(MIFont)
        case setTextColor(MIColor)
        case setBackgroundColor(MIColor)
        case requestTerminalSize
        // cursor operation
        case setCursorVisible(Bool)
        case blinkCursor(Bool)

        public var description: String { get {
                let result: String
                switch self {
                case .insertText(let txt):
                        result = "insertText(\"\(txt)\")"
                case .insertNewline:
                        result = "insertNewline"
                case .insertTab:
                        result = "insertTab"
                case .moveCursorToHome:
                        result = "moveCursorToHome"
                case .moveCursorBackward(let n):
                        result = "moveCursorBackward(\(n))"
                case .moveCursorForward(let n):
                        result = "moveCursorForward(\(n))"
                case .moveCursorUp(let n):
                        result = "moveCursorUp(\(n))"
                case .moveCursorDown(let n):
                        result = "moveCursorDown(\(n))"
                case .moveCursorToBeginningOfLine:
                        result = "moveCursorToBeginningOfLine"
                case .moveCursorToEndOfLine:
                        result = "moveCursorToEndOfLine"
                case .moveCursorToBeginingOfPreviousLine:
                        result = "moveCursorToBeginingOfPreviousLine"
                case .moveCursorToBeginingOfNextLine:
                        result = "moveCursorToBeginingOfNextLine"
                case .moveCursorToPoint(let row, let col):
                        result = "moveCursorToPoint(\(row), \(col))"
                case .requireCursorPosition:
                        result = "requireCursorPosition"
                case .removeForward(let n):
                        result = "removeForward(\(n))"
                case .removeBackward(let n):
                        result = "removeBackward(\(n))"
                case .removeAll:
                        result = "removeAll"
                case .setFont(_):
                        result = "setFont()"
                case .setTextColor(_):
                        result = "setTextColor()"
                case .setBackgroundColor(_):
                        result = "setBackgroundColor()"
                case .requestTerminalSize:
                        result = "requestTerminalSize"
                case .setCursorVisible(let f):
                        result = "setCursorVisible(\(f))"
                case .blinkCursor(let f):
                        result = "blinkCursor(\(f))"
                }
                return result
        }}
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
                case .insertNewline:
                        strg.insertNewline()
                case .insertTab:
                        strg.insertTab()
                case .moveCursorToHome:
                        strg.moveCursorToHome()
                case .moveCursorForward(let offset):
                        strg.moveCursorForward(offset: offset)
                case .moveCursorBackward(let offset):
                        strg.moveCursorBackward(offset: offset)
                case .moveCursorUp(let lines):
                        strg.moveCursorUp(lines: lines)
                case .moveCursorDown(let lines):
                        strg.moveCursorDown(lines: lines)
                case .moveCursorToBeginningOfLine:
                        let _ = strg.moveCursorToBeginningOfLine()
                case .moveCursorToEndOfLine:
                        let _ = strg.moveCursorToEndOfLine()
                case .moveCursorToBeginingOfNextLine:
                        strg.moveCursorToBeginningOfNextLine(lines: 1)
                case .moveCursorToBeginingOfPreviousLine:
                        strg.moveCursorToBeginningOfPreviousLine(lines: 1)
                case .moveCursorToPoint(let row, let col):
                        strg.moveCursorToPoint(row: row, column: col)
                case .requireCursorPosition:
                        let (col, row) = strg.cursorPoint
                        NSLog("cursorPosition: \(col), \(row)")
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
                case .requestTerminalSize:
                        if let receiver = commandResponceReceiver() {
                                let (width, height) = terminalSize()
                                receiver(.returnConsoleSize(width, height))
                        }
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
                self.cursor.blink = doblink
        }
}
