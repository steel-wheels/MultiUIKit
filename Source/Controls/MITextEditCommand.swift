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
        case moveCursorBackward(Int)
        case moveCursorForward(Int)
        case removeForward(Int)
        case removeBackward(Int)
        case removeAll
        case setFont(MIFont)
        case setTextColor(MIColor)
        case setBackgroundColor(MIColor)
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
                let storage = self.textStorage
                storage.beginEditing()
                for cmd in cmds {
                        execute(command: cmd, storage: storage)
                }
                storage.endEditing()
                storage.notify()
        }

        private func execute(command cmd: MITextEditCommand, storage strg: MITextStorage) {
                switch cmd {
                case .insertText(let str):
                        strg.insert(string: str)
                case .moveCursorForward(let offset):
                        strg.moveCursorForword(offset: offset)
                case .moveCursorBackward(let offset):
                        strg.moveCursorBackword(offset: offset)
                case .removeForward(let len):
                        strg.removeForward(length: len)
                case .removeBackward(let len):
                        strg.removeBackward(length: len)
                case .removeAll:
                        strg.removeAll()
                case .setFont(let font):
                        strg.setFont(font)
                case .setTextColor(let col):
                        strg.setTextColor(color: col)
                case .setBackgroundColor(let col):
                        strg.setBackgoundColor(color: col)
                }
        }
}
