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
                case font(MIFont)
                case append(String)
        }

        private struct TextAttribute {
                public var font:                MIFont
                public var textColor:           MIColor
                public var backgroundColor:     MIColor

                public init(){
                        font             = MIFont.systemFont(ofSize: 12.0)
                        textColor        = MIColor.black
                        backgroundColor  = MIColor.white
                }
        }

        private var mStorage:           NSTextStorage
        private var mCurrentIndex:      String.Index
        private var mParagraphStyle:    NSMutableParagraphStyle
        private var mTextAtrribute:     TextAttribute

        public init(string str: NSTextStorage){
                mStorage               = str
                mCurrentIndex          = mStorage.string.startIndex
                mParagraphStyle        = NSMutableParagraphStyle()
                mTextAtrribute         = TextAttribute()
                /* init style */
                mParagraphStyle.headIndent              = 0.0
                mParagraphStyle.firstLineHeadIndent     = 0.0
                mParagraphStyle.tailIndent              = 0.0

                updateParagraphStyle(fontSize: mTextAtrribute.font.pointSize)
        }

        private func updateParagraphStyle(fontSize sz: CGFloat) {
                mParagraphStyle.lineHeightMultiple      =  1.0
                mParagraphStyle.maximumLineHeight       =  sz
                mParagraphStyle.minimumLineHeight       =  0.0
                mParagraphStyle.lineSpacing             =  2.0
                mParagraphStyle.paragraphSpacing        =  0.0
                mParagraphStyle.paragraphSpacingBefore  =  2.0
        }

        public var string: String { get {
                return mStorage.string
        }}

        public func addLayoutManager(_ manager: NSLayoutManager) {
                mStorage.addLayoutManager(manager)
        }

        public func update(commands cmds: Array<Command>) {
                mStorage.beginEditing()
                for cmd in cmds {
                        update(command: cmd)
                }
                mStorage.endEditing()
        }

        private func update(command cmd: Command) {
                switch cmd {
                case .font(let font):
                        mTextAtrribute.font = font
                        updateParagraphStyle(fontSize: font.pointSize)
                case .textColor(let col):
                        mTextAtrribute.textColor       = col
                case .backgroundColor(let col):
                        mTextAtrribute.backgroundColor = col
                case .append(let str):
                        mStorage.append(allocate(str))
                        mCurrentIndex = mStorage.string.endIndex
                }
        }

        private func allocate(_ str: String) -> NSAttributedString {
                let attrs: Dictionary<NSAttributedString.Key, Any> = [
                        NSAttributedString.Key.paragraphStyle:  mParagraphStyle,
                        NSAttributedString.Key.font:            mTextAtrribute.font,
                        NSAttributedString.Key.foregroundColor: mTextAtrribute.textColor,
                        NSAttributedString.Key.backgroundColor: mTextAtrribute.backgroundColor
                ]
                return NSAttributedString(string: str, attributes: attrs)
        }
}
