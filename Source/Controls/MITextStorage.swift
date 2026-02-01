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

        public enum EventType {
                case textAttribute(MITextAttribute)
        }

        /*
         * The storage contains the last space to put the cursor
         */
        private var mStorage:           NSTextStorage
        private var mCurrentIndex:      Int
        private var mParagraphStyle:    NSMutableParagraphStyle
        private var mTextAtrributes:    MITextAttributes
        private var mFrameSize:         CGSize
        private var mContentsSize:      CGSize?
        private var mNotifyUpdate:      NotifyUpdateFunc?

        public init(){
                mStorage               = NSTextStorage()
                mCurrentIndex          = 0
                mParagraphStyle        = NSMutableParagraphStyle()
                mTextAtrributes        = MITextAttributes()
                mFrameSize             = CGSize.zero
                mContentsSize          = nil
                mNotifyUpdate          = nil

                /* init style */
                mParagraphStyle.headIndent              = 0.0
                mParagraphStyle.firstLineHeadIndent     = 0.0
                mParagraphStyle.tailIndent              = 0.0

                let fontsz = mTextAtrributes.current.font.pointSize
                updateParagraphStyle(fontSize: fontsz)
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
                mStorage        = strg
                mCurrentIndex   = 0
                /* put last space */
                let astr = allocateString(" ")
                mStorage.insert(astr, at: mCurrentIndex)
        }

        public var validLength: Int { get {
                return mStorage.length - 1
        }}

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
                return mStorage
        }}

        public var lineSpacing: CGFloat {get {
                return mParagraphStyle.lineSpacing
        }}

        public var currentIndex: Int {
                get      { return mCurrentIndex }
                set(val) { mCurrentIndex = val}
        }

        public func addLayoutManager(_ manager: NSLayoutManager) {
                mStorage.addLayoutManager(manager)
        }

        public func beginEditing() {
                mStorage.beginEditing()
        }

        public func endEditing() {
                mStorage.endEditing()
        }

        public func character(at idx: Int) -> String {
                let range = NSRange(location: idx, length: 1)
                return mStorage.attributedSubstring(from: range).string
        }

        public func attribute(at idx: Int) -> MITextAttribute {
                var range = NSRange(location: 0, length: 1)
                let attrs = mStorage.attributes(at: idx, effectiveRange: &range)
                return MITextAttribute.fromAttribute(attrs)
        }

        public func insert(string str: String) {
                let astr = allocateString(str)
                mStorage.insert(astr, at: mCurrentIndex)
                mCurrentIndex += astr.length
        }

        public func moveCursorToHome() {
                mCurrentIndex = 0
        }

        public func moveCursorForword(offset off: Int) {
                mCurrentIndex = min(self.validLength - 1, mCurrentIndex + off)
        }

        public func moveCursorBackword(offset off: Int) {
                mCurrentIndex = max(0, mCurrentIndex - off)
        }

        public func removeForward(length off: Int) {
                let len  = min(self.validLength - mCurrentIndex, off)
                let loc  = mCurrentIndex
                let range = NSRange(location: loc, length: len)
                mStorage.replaceCharacters(in: range, with: "")
                // current index is not changed
        }

        public func removeBackward(length off: Int) {
                let len   = min(self.validLength, off)
                let loc   = min(0, mCurrentIndex - len)
                let range = NSRange(location: loc, length: len)
                mStorage.replaceCharacters(in: range, with: "")
                mCurrentIndex -= len
        }

        public func removeAll() {
                let range  = NSRange(location: 0, length: self.validLength)
                mStorage.replaceCharacters(in: range, with: "")
        }

        public func setFont(_ font: MIFont) {
                mTextAtrributes.current.font = font
                updateParagraphStyle(fontSize: font.pointSize)
        }

        public func setTextColor(color col: MIColor) {
                mTextAtrributes.current.textColor = col
        }

        public func setBackgoundColor(color col: MIColor) {
                mTextAtrributes.current.backgroundColor = col
        }

        public func notify() {
                if let notiffunc = mNotifyUpdate {
                        notiffunc(.textAttribute(mTextAtrributes.current))
                }
        }

        private func allocateString(_ str: String) -> NSAttributedString {
                let attr = mTextAtrributes.current.attributes
                return NSAttributedString(string: str, attributes: attr)
        }
}
