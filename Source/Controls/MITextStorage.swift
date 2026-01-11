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
        public typealias NotifyUpdateFunc = (_ : EventType) -> Void

        public enum Command {
                case fullReplace(NSAttributedString)
        }

        public struct TextAttribute {
                public var font:                MIFont
                public var textColor:           MIColor
                public var backgroundColor:     MIColor

                public init(){
                        font             = MIFont.systemFont(ofSize: 12.0)
                        textColor        = MIColor.black
                        backgroundColor  = MIColor.white
                }
        }

        public enum EventType {
                case textAttribute(TextAttribute)
        }

        private var mStorage:           NSTextStorage?
        private var mCurrentIndex:      Int
        private var mParagraphStyle:    NSMutableParagraphStyle
        private var mTextAtrribute:     TextAttribute
        private var mFrameSize:         CGSize
        private var mContentsSize:      CGSize?
        private var mNotifyUpdate:      NotifyUpdateFunc?

        public init(){
                mStorage               = nil
                mCurrentIndex          = 0
                mParagraphStyle        = NSMutableParagraphStyle()
                mTextAtrribute         = TextAttribute()
                mFrameSize             = CGSize.zero
                mContentsSize          = nil
                mNotifyUpdate          = nil

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

        public func setCoreStorage(_ strg: NSTextStorage) {
                mStorage = strg
        }

        public func setNotification(_ notif: @escaping NotifyUpdateFunc) {
                mNotifyUpdate = notif
        }

        open var frameSize: CGSize {
                get { return mFrameSize }
                set(newval){ mFrameSize = newval }
        }

        public var contentsSize: CGSize? {
                get { return mContentsSize }
                set(newval){ mContentsSize = newval }
        }

        public var fontSize: CGSize { get {
                let astr  = allocateString(" ")
                return astr.size()
        }}

        public var context: NSAttributedString { get {
                if let strg = mStorage {
                        return strg
                } else {
                        NSLog("[Error] No core storage at \(#function) in \(#file)")
                        return NSMutableAttributedString(string: "")
                }
        }}

        public var lineSpacing: CGFloat {get {
                return mParagraphStyle.lineSpacing
        }}

        public var currentIndex: Int {
                get      { return mCurrentIndex }
                set(val) { mCurrentIndex = val}
        }

        public var length: Int { get {
                if let storage = mStorage {
                        return storage.length
                } else {
                        NSLog("[Error] No core storage at \(#function) in \(#file)")
                        return 0
                }
        }}

        public func addLayoutManager(_ manager: NSLayoutManager) {
                if let storage = mStorage {
                        storage.addLayoutManager(manager)
                } else {
                        NSLog("[Error] No core storage at \(#function) in \(#file)")
                }
        }

        public func beginEditing() {
                mStorage?.beginEditing()
        }

        public func endEditing() {
                mStorage?.endEditing()
        }

        public func insert(string str: String) {
                let astr = allocateString(str)
                mStorage?.insert(astr, at: mCurrentIndex)
                mCurrentIndex += astr.length
        }

        public func moveCursorForword(offset off: Int) {
                mCurrentIndex = min(self.length - 1, mCurrentIndex + off)
        }

        public func moveCursorBackword(offset off: Int) {
                mCurrentIndex = max(0, mCurrentIndex - off)
        }

        public func removeForward(length off: Int) {
                let len  = min(self.length - mCurrentIndex, off)
                let loc  = mCurrentIndex
                let range = NSRange(location: loc, length: len)
                mStorage?.replaceCharacters(in: range, with: "")
                // current index is not changed
        }

        public func removeBackward(length off: Int) {
                let len   = min(self.length, off)
                let loc   = min(0, mCurrentIndex - len)
                let range = NSRange(location: loc, length: len)
                mStorage?.replaceCharacters(in: range, with: "")
                mCurrentIndex -= len
        }

        public func removeAll() {
                let range  = NSRange(location: 0, length: self.length)
                mStorage?.replaceCharacters(in: range, with: "")
        }

        public func setFont(_ font: MIFont) {
                mTextAtrribute.font = font
                updateParagraphStyle(fontSize: font.pointSize)
        }

        public func setTextColor(color col: MIColor) {
                mTextAtrribute.textColor = col
        }

        public func setBackgoundColor(color col: MIColor) {
                mTextAtrribute.backgroundColor = col
        }

        public func notify() {
                if let notiffunc = mNotifyUpdate {
                        notiffunc(.textAttribute(mTextAtrribute))
                }
        }

        private var currentAttributes: Dictionary<NSAttributedString.Key, Any> { get {
                let attrs: Dictionary<NSAttributedString.Key, Any> = [
                        NSAttributedString.Key.paragraphStyle:  mParagraphStyle,
                        NSAttributedString.Key.font:            mTextAtrribute.font,
                        NSAttributedString.Key.foregroundColor: mTextAtrribute.textColor,
                        NSAttributedString.Key.backgroundColor: mTextAtrribute.backgroundColor
                ]
                return attrs
        }}

        private func allocateString(_ str: String) -> NSAttributedString {
                return NSAttributedString(string: str, attributes: self.currentAttributes)
        }
}
