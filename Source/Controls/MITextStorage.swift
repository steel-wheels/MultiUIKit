/*
 * @file MITextView.swift
 * @description Define MITextView class
 * @par Copyright
 *   Copyright (C) 2025 Steel Wheels Project
 */

#if os(OSX)
import  AppKit
#else   // os(OSX)
import  UIKit
#endif  // os(OSX)

public class MITextStorage
{
        public enum Command {
                case textColor(MIColor)
                case backgroundColor(MIColor)
                case append(String)
        }

        private struct TextArributeType {
                public var font:                MIFont?
                public var textColor:           MIColor?
                public var backgroundColor:     MIColor?

                public init() {
                        self.font               = nil
                        self.textColor          = nil
                        self.backgroundColor    = nil
                }
        }

        private var mStorage:          NSTextStorage
        private var mCurrentIndex:     String.Index
        private var mAttribute:        TextArributeType

        public init(string str: NSTextStorage){
                mStorage               = str
                mCurrentIndex          = mStorage.string.startIndex
                mAttribute             = TextArributeType()
        }

        public var string: String { get {
                return mStorage.string
        }}

        public func update(commands cmds: Array<Command>) {
                mStorage.beginEditing()
                for cmd in cmds {
                        update(command: cmd)
                }
                mStorage.endEditing()
        }

        private func update(command cmd: Command) {
                switch cmd {
                case .textColor(let col):
                        mAttribute.textColor = col
                case .backgroundColor(let col):
                        mAttribute.backgroundColor = col
                case .append(let str):
                        mStorage.append(allocate(str))
                        mCurrentIndex = mStorage.string.endIndex
                }
        }

        private func allocate(_ str: String) -> NSAttributedString {
                var attrs: Dictionary<NSAttributedString.Key, Any> = [:]
                if let font = mAttribute.font {
                        attrs[NSAttributedString.Key.font] = font
                }
                if let color = mAttribute.textColor {
                        attrs[NSAttributedString.Key.foregroundColor] = color
                }
                if let color = mAttribute.backgroundColor {
                        attrs[NSAttributedString.Key.backgroundColor] = color
                }
                return NSAttributedString(string: str, attributes: attrs)
        }
}
