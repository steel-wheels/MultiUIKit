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
        public enum EventType {
                case textAttribute(MITextAttribute)
        }

        /*
         * The storage contains the last space to put the cursor
         */
        private var mStorage:           NSTextStorage
        private var mCurrentIndex:      String.Index
        private var mParagraphStyle:    NSMutableParagraphStyle
        private var mTextAttributes:    MITextAttributes
        private var mFrameSize:         CGSize
        private var mContentsSize:      CGSize?

        public init(){
                mStorage               = NSTextStorage()
                mCurrentIndex          = mStorage.string.startIndex
                mParagraphStyle        = NSMutableParagraphStyle()
                mTextAttributes        = MITextAttributes()
                mFrameSize             = CGSize.zero
                mContentsSize          = nil

                /* allocate default font */
                let font = MIFont.monospacedSystemFont(ofSize: 13, weight: .regular)
                mTextAttributes.current.font = font

                /* init style */
                mParagraphStyle.headIndent              = 0.0
                mParagraphStyle.firstLineHeadIndent     = 0.0
                mParagraphStyle.tailIndent              = 0.0
                updateParagraphStyle(fontSize: font.pointSize)
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
                mCurrentIndex   = strg.string.startIndex
                /* put last space */
                insert(string: " ")
        }

        public var currentIndex: String.Index { get {
                return mCurrentIndex
        }}

        public var cursorPosition: Int { get {
                return mCurrentIndex.utf16Offset(in: mStorage.string)
        }}

        public var validLength: Int { get {
                return mStorage.string.lengthOfBytes(using: .utf8) - 1
        }}

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

        public func addLayoutManager(_ manager: NSLayoutManager) {
                mStorage.addLayoutManager(manager)
        }

        public func beginEditing() {
                mStorage.beginEditing()
        }

        public func endEditing() {
                mStorage.endEditing()
        }

        public func attribute(at idx: Int) -> MITextAttribute {
                let attrs = mStorage.attributes(at: idx, effectiveRange: nil)
                return MITextAttribute.fromAttribute(attrs)
        }

        public func setFont(_ font: MIFont) {
                mTextAttributes.current.font = font
                updateParagraphStyle(fontSize: font.pointSize)
        }

        public func setTextColor(color col: MIColor) {
                mTextAttributes.current.textColor = col
        }

        public func setBackgoundColor(color col: MIColor) {
                mTextAttributes.current.backgroundColor = col
        }

        private func allocateString(_ str: String) -> NSAttributedString {
                let attr = mTextAttributes.current.attributes
                return NSAttributedString(string: str, attributes: attr)
        }
}

extension MITextStorage
{
        public func currentCharacter() -> Character {
                return mStorage.string[mCurrentIndex]
        }

        public func currentAttribute() -> MITextAttribute {
                return attribute(at: self.cursorPosition)
        }

        public func nextCharacter() -> Character? {
                let str     = mStorage.string
                let nextidx = str.index(after: mCurrentIndex)
                if nextidx < str.endIndex {
                        return str[nextidx]
                } else {
                        return nil
                }
        }

        public func previousCharacter() -> Character? {
                let str     = mStorage.string
                if str.startIndex < mCurrentIndex {
                        let previdx = str.index(before: mCurrentIndex)
                        return str[previdx]
                }
                return nil
        }

        /*
         * move cursor
         */

        public func moveCursorToHome() {
                mCurrentIndex = mStorage.string.startIndex
        }

        public func moveCursorForward(offset off: Int) {
                let str = mStorage.string
                for _ in 0..<off {
                        if let c = nextCharacter() {
                                if c != "\n" {
                                        mCurrentIndex = str.index(after: mCurrentIndex)
                                } else {
                                        break
                                }
                        } else {
                                break
                        }
                }
        }

        public func moveCursorBackward(offset off: Int) {
                let str = mStorage.string
                for _ in 0..<off {
                        if let c = previousCharacter() {
                                if c != "\n" {
                                        mCurrentIndex = str.index(before: mCurrentIndex)
                                } else {
                                        break
                                }
                        } else {
                                break
                        }
                }
        }

        /*
         * Edit text
         */

        public func insert(string str: String) {
                let astr   = allocateString(str)
                insert(attributedString: astr)
        }

        public func insert(attributedString str: NSAttributedString) {
                let offset = mCurrentIndex.utf16Offset(in: mStorage.string)
                mStorage.insert(str, at: offset)
        }

        public func set(attribute attr: MITextAttribute, length len: Int) {
                let offset = mCurrentIndex.utf16Offset(in: mStorage.string)
                let range  = NSRange(location: offset, length: len)
                mStorage.setAttributes(attr.attributes, range: range)
        }

        public func deleteForward(length len: Int) {
                let str      = mStorage.string
                let startidx = mCurrentIndex
                var curidx   = startidx
                let endidx   = str.endIndex
                for _ in 0..<len {
                        if curidx < endidx {
                                if str[curidx] != "\n" {
                                        curidx = str.index(after: curidx)
                                } else {
                                        break
                                }
                        } else {
                                break
                        }
                }
                delete(fromIndex: startidx, toIndent: curidx)
        }

        public func deleteBackward(length len: Int) {
                let str      = mStorage.string
                let startidx = str.startIndex
                var curidx   = mCurrentIndex
                for _ in 0..<len {
                        if startidx <= curidx {
                                if str[curidx] != "\n" {
                                        curidx = str.index(before: curidx)
                                } else {
                                        break
                                }
                        } else {
                                break
                        }
                }
                delete(fromIndex: curidx, toIndent: mCurrentIndex)
        }

        private func delete(fromIndex fidx: String.Index, toIndent tidx: String.Index) {
                let str  = mStorage.string
                let loc  = fidx.utf16Offset(in: str)
                let last = tidx.utf16Offset(in: str)
                let len  = last - loc
                if len > 0 {
                        let range = NSRange(location: loc, length: len)
                        mStorage.deleteCharacters(in: range)
                }
        }

        public func deleteAll() {
                let range = NSRange(location: 0, length: mStorage.length)
                mStorage.replaceCharacters(in: range, with: " ")
                mCurrentIndex = mStorage.string.startIndex
        }
}


